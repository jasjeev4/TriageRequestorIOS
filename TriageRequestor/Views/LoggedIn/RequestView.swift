//
//  RequestView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct RequestView: View {
    @EnvironmentObject var viewModel: RequestorViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
        
            VStack {
                TranscriptView()
                
                Spacer()
                
                RecordButtonView()
                    .padding(100)
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            viewModel.logout()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        })
                }
            }
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
