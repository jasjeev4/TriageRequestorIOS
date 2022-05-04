//
//  RequestView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI
import AlertToast

struct RequestView: View {
    @EnvironmentObject var viewModel: RequestorViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
        
            VStack {
                Spacer()
                    .frame(height: 50)
                
                ZStack {
                    ProgressView(value: viewModel.progressTime, total: 3.0)
                        .tint(.green)
                        //.offset(y: 50)
                        .opacity(viewModel.showProgress ? 1 : 0)
            
                    ProgressView(value: viewModel.pulseProgressVal, total: 100)
                        .tint(.gray)
                        //.offset(y: 50)
                        .opacity(viewModel.recording && viewModel.transcript == "" ? 1 : 0)
                }
                
                Group {
                    
                    Spacer()
                    
                    Text("Submitting:")
                        .font(Font.custom("IndieFlower", size: 42))
                        .padding()
                        .foregroundColor(Color.green)
                        .opacity(viewModel.showProgress ? 1 : 0)
                
                    TranscriptView()
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.resetSpeech()
                        // cancel submit to backend
                        
                    }) {
                        Text("Cancel?")
                            .font(Font.custom("GloriaHallelujah", size: 30))
                            .padding()
                            .background(Color.black)
                            .foregroundColor(Color.red)
                            .clipShape(Capsule())
                        
                    }.opacity(viewModel.showProgress ? 1 : 0)
                
                    Spacer()
                    
                    RecordButtonView()
                        .padding(50)
                        .opacity(viewModel.showRecord ? 1 : 0)
                    
                    Text("You didn't say anything.")
                        .opacity(viewModel.saySomething ? 1 : 0)
                }
                
                Spacer()
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
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button {
                    } label: {
                        if(viewModel.email != nil) {
                            Image(emailToName[viewModel.email!]!)
                                .resizable()
                                .frame(width: 30.0, height: 30.0)
                                .clipShape(Circle())
                        }
                        
                    }
                }
            }
            .toast(isPresenting: $viewModel.acceptedDesire) {
                AlertToast(type: .complete(Color.green), title: "Got it!")
            }
            .toast(isPresenting: $viewModel.rejectedDesire){
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: "Sorry! 🙅 Try another request!")
            }
            
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
