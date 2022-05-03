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
            
            Text(viewModel.transcript)
            
            Spacer()
        }
    }
}

struct TranscriptView_Previews: PreviewProvider {
    static var previews: some View {
        TranscriptView()
    }
}
