//
//  RequestView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct RequestView: View {
    @EnvironmentObject var viewModel: RequestorViewModel
    
    var body: some View {
        VStack {
            TranscriptView()
            
            Spacer()
            
            RecordButtonView()
                .padding(100)
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
