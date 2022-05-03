//
//  RequestorViewModel.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import Foundation

final class RequestorViewModel: ObservableObject {
    private var defaults = UserDefaults.standard
    
    @Published public var signedIn = false
    
    private var email: String?
    
    @Published public var speechRecognizer = SpeechRecognizer()
    
    @Published public var transcript = ""
    
    func checkLogin() {
        let prevEmail = defaults.string(forKey: "Email")
        
        if(prevEmail != nil && prevEmail != "") {
            loginEmail(email: prevEmail!)
        }
    }
    
    
    func loginEmail(email: String) {
        self.email = email
        
        // add to UserDefaults
        defaults.set(email, forKey: "Email")
        
        signedIn = true
    }
    
    func logout() {
        self.email = nil
        
        defaults.set(nil, forKey: "Email")
        
        signedIn = false
    }
}
