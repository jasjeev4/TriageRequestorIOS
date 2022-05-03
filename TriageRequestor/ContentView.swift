//
//  ContentView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RequestorViewModel()
    
    var body: some View {
        Text(viewModel.transcript)
            .padding()
            .onAppear {
                viewModel.speechRecognizer.record(to: $viewModel.transcript)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
