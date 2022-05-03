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
        Group {
        
            if(viewModel.signedIn) {
                RequestView()
                    .environmentObject(viewModel)
            }
            else {
                LoginView()
                    .environmentObject(viewModel)
            }
        }
            .onAppear {
                viewModel.checkLogin()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
