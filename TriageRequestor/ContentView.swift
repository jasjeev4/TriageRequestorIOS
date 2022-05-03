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
        
        if(viewModel.signedIn) {
            RequestView()
                .environmentObject(viewModel)
        }
        else {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
