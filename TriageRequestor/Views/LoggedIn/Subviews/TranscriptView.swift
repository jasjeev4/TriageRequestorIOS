//
//  TranscriptView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct TranscriptView: View {
    @EnvironmentObject var viewModel: RequestorViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack {
                if(viewModel.desire != "") {
                    Text(viewModel.desire)
                        .font(Font.custom("IndieFlower", size: 30))
                        .multilineTextAlignment(.leading)
                        .background(viewModel.recording ? .white : .black)
                        .foregroundColor(viewModel.recording ? .black : .white)
                }
                else if(viewModel.transcript != "") {
                    Text(viewModel.transcript)
                        .font(Font.custom("IndieFlower", size: 30))
                        .multilineTextAlignment(.leading)
                        .background(viewModel.recording ? .white : .black)
                        .foregroundColor(viewModel.recording ? .black : .white)
                }
                else {
                    Text("What would you like?")
                        .font(Font.custom("IndieFlower", size: 30))
                        .multilineTextAlignment(.leading)
                        .background(.white)
                        .foregroundColor(.gray)
                }
                
            }
            .frame(minHeight: 300, maxHeight: 300)
            .padding(20)
            
            Spacer()
        }
    }
}

struct TranscriptView_Previews: PreviewProvider {
    static var previews: some View {
        TranscriptView()
    }
}
