//
//  RecordButtonView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct RecordButtonView: View {
    @EnvironmentObject var viewModel: RequestorViewModel
    
    @State private var animationAmount: CGFloat = 1
    @State private var buttonTapped: Bool = false
    
    var body: some View {
        
        Button(action: {
            viewModel.showRecord = false
            viewModel.recording = false
            // called after button tap complete
            if(viewModel.transcript == "") {
                viewModel.saySomething = true
                viewModel.resetSpeech()
            }
            else {
                viewModel.saySomething = false
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                
                    self.buttonTapped = false
                    viewModel.speechRecognizer.stopRecording()
                    
                    // submit to backend
                    viewModel.submitDesire()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                        if(viewModel.transcript != "") {
                            viewModel.desire = "‟" + viewModel.transcript + "”"
                        }
                    }
                }
            }
        }) {
            Image(systemName: "mic.circle.fill")
                .resizable()
                .frame(width: 75.0, height: 75.0)
                .clipShape(Circle())
            
        }
        .foregroundColor(Color.black)
        .simultaneousGesture((LongPressGesture(minimumDuration: 0.1).onEnded({ _ in
            // actions during button hold
            viewModel.saySomething = false
            self.buttonTapped = true
            viewModel.recording = true
            viewModel.resetPulse()
            viewModel.speechRecognizer.record(to: $viewModel.transcript)
        })))
    }
}

struct RecordButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RecordButtonView()
    }
}
