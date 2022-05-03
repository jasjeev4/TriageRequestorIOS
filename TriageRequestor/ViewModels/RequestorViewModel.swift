//
//  RequestorViewModel.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import Foundation

final class RequestorViewModel: ObservableObject {
    @Published public var signedIn = false
    
    
    @Published public var speechRecognizer = SpeechRecognizer()
    
    @Published public var transcript = ""
}
