//
//  SpeechHelper.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

/// A helper for transcribing speech to text using AVAudioEngine.
class SpeechRecognizer {
    private var lastModified = Date().timeIntervalSince1970
    private var checkTimer:Timer? = nil
    
    private class SpeechAssist {
        var audioEngine: AVAudioEngine?
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?
        let speechRecognizer = SFSpeechRecognizer()

        deinit {
            reset()
        }

        func reset() {
            recognitionTask?.cancel()
            audioEngine?.stop()
            audioEngine = nil
            recognitionRequest = nil
            recognitionTask = nil
        }
    }

    private let assistant = SpeechAssist()

    /**
        Begin transcribing audio.
     
        Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopRecording()`.
        The resulting transcription is continuously written to the provided text binding.
     
        -  Parameters:
            - speech: A binding to a string where the transcription is written.
     */
    func record(to speech: Binding<String>) {
        // relay(speech, message: "Requesting access")
        canAccess { [self] authorized in
            guard authorized else {
                // relay(speech, message: "Access denied")
                return
            }

            // relay(speech, message: "Access granted")

            assistant.audioEngine = AVAudioEngine()
            guard let audioEngine = assistant.audioEngine else {
                fatalError("Unable to create audio engine")
            }
            assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = assistant.recognitionRequest else {
                fatalError("Unable to create request")
            }
            recognitionRequest.shouldReportPartialResults = true

            do {
                // relay(speech, message: "Booting audio subsystem")

                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                let inputNode = audioEngine.inputNode
                // relay(speech, message: "Found input node")

                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    recognitionRequest.append(buffer)
                }
                // relay(speech, message: "Preparing audio engine")
                audioEngine.prepare()
                lastModified = Date().timeIntervalSince1970
                //checkComplete()
                try audioEngine.start()
                assistant.recognitionTask = assistant.speechRecognizer?.recognitionTask(with: recognitionRequest) { (result, error) in
                    var isFinal = false
                    if let result = result {
                        let changedTime = Date().timeIntervalSince1970
                        let delta = lastModified.distance(to: changedTime)
                        //print(delta)
                        lastModified = changedTime
                        relay(speech, message: result.bestTranscription.formattedString)
                        isFinal = result.isFinal
                    }

                    if error != nil || isFinal {
                        audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.assistant.recognitionRequest = nil
                    }
                }
            } catch {
                print("Error transcibing audio: " + error.localizedDescription)
                assistant.reset()
            }
        }
    }
    
    func checkComplete() {
        // check for 3.0 second pauses
        
        let changedTime = Date().timeIntervalSince1970
        let delta = lastModified.distance(to: changedTime)
        print(delta)
        if(delta>3.0) {
            // submit the recording
            submitTranscript()

            // reset assistant
            assistant.reset()
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.checkComplete()
            }
        }
    }
        
//        checkTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [self] timer in
//            let changedTime = Date().timeIntervalSince1970
//            let delta = lastModified.distance(to: changedTime)
//            print(delta)
//            if(delta>1.2) {
//                // end the timer
//                timer.invalidate()
//
//                // submit the recording
//                submitTranscript()
//
//                // reset assistant
//                assistant.reset()
//            }
//
//            lastModified = changedTime
//        }
    
    
    func submitTranscript() {
        print("Submit called")
        // check for transcript not blank
    }
    
    /// Stop transcribing audio.
    func stopRecording() {
        assistant.reset()
    }
    
    private func canAccess(withHandler handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            if status == .authorized {
                AVAudioSession.sharedInstance().requestRecordPermission { authorized in
                    handler(authorized)
                }
            } else {
                handler(false)
            }
        }
    }
    
    private func relay(_ binding: Binding<String>, message: String) {
        DispatchQueue.main.async {
            binding.wrappedValue = message
        }
    }
}
