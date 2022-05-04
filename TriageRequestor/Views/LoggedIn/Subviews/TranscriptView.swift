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
                Text(viewModel.transcript)
                    .font(Font.custom("IndieFlower", size: 30))
                    .multilineTextAlignment(.leading)
            }
            .frame(minHeight: 500, maxHeight: 500)
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
