//
//  RequestorViewModel.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class RequestorViewModel: ObservableObject {
    private var defaults = UserDefaults.standard
    
    @Published public var signedIn = false
    
    internal var email: String?
    
    @Published public var user: String?
    
    @Published public var recording: Bool = false
    @Published public var showRecord: Bool = true
    
    @Published public var speechRecognizer = SpeechRecognizer()
    
    @Published public var transcript = ""
    
    @Published public var showProgress = false
    @Published public var progressTime: Float = 0.0
    @Published public var showCancelButton = false
    
    @Published public var acceptedDesire = false
    @Published public var rejectedDesire = false
    
    
    @Published public var pulseProgressVal: Float = 0.0
    internal var pulsePostive = true
    internal var desire: String = ""
    
    @Published public var saySomething: Bool = false
    
    
    func submitDesire() {
        desire = transcript
        showProgress = true
        showCancelButton = true
        progressTime = 0.0
        
        runProgressTimer()
    }
            
    func runProgressTimer() {
        // run progress indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [self] in
            progressTime = progressTime + 0.01
            
            if(showProgress == true && progressTime<3.0) {
                runProgressTimer()
            }
            else {
                postDesire()
            }
        }
    }
    
    func postDesire() {
        let postPath = TriageApi.postDesire()
        
        let params = [
            "desire": desire,
            "email": email!
        ]
        
        AF.request(postPath, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { [self] response in
                  switch response.result {
                  case .success(let response):
                     // debugPrint(response)
                    parseResponse(data: response)
                    // do something with the response
                      self.resetSpeech()
                  case .failure(let error):
                    print(error.localizedDescription)
                    // show toast
              }

//            .response { resp in
//                switch resp.result {
//                    case .success:
//                        print("Sucessfully uploaded ")
//                    case .failure:
//                        debugPrint(resp)
//                }
        
        

        }
    }
    
    func parseResponse(data: Any) {
        let json = JSON(data)
        
        if(json[0]["requests"].count > 0) {
            // ml accepted
            acceptedDesire = true
        }
        else {
            rejectedDesire = true
        }
        
        debugPrint(json)
    }
    
    func checkLogin() {
        let prevEmail = defaults.string(forKey: "Email")
        
        if(prevEmail != nil && prevEmail != "") {
            loginEmail(email: prevEmail!)
        }
    }
    
    func loginEmail(email: String) {
        self.email = email
        
        // add to UserDefaults
        defaults.set(email, forKey: "Email")
        
        signedIn = true
    }
    
    func logout() {
        self.transcript = ""
        
        self.email = nil
        
        defaults.set(nil, forKey: "Email")
        
        signedIn = false
    }

    func resetPulse() {
        pulsePostive = true
        pulseProgressVal = 0.0
        runPulse()
    }
    
    func runPulse() {
        // run progress indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [self] in
            if(pulsePostive) {
                pulseProgressVal = pulseProgressVal + 1
            }
            else {
                pulseProgressVal = pulseProgressVal - 1
            }
            
            if(pulseProgressVal == 0 || pulseProgressVal == 100) {
                pulsePostive.toggle()
            }
            
            if(recording) {
                runPulse()
            }
        }
    }
    
    func resetSpeech() {
        showRecord = true
        speechRecognizer.stopRecording()
        recording = false
        showProgress = false
        
        transcript = ""
    }
}
