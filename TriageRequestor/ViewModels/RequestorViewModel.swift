//
//  RequestorViewModel.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import Foundation
import Alamofire

final class RequestorViewModel: ObservableObject {
    private var defaults = UserDefaults.standard
    
    @Published public var signedIn = false
    
    internal var email: String?
    
    @Published public var user: String?
    
    @Published public var speechRecognizer = SpeechRecognizer()
    
    @Published public var transcript = ""
    
    
    func submitDesire() {
        let postPath = TriageApi.postDesire()
        
        let params = [
            "desire": transcript,
            "email": email!
        ]
        
        AF.request(postPath, method: .post, parameters: params, encoding: URLEncoding.queryString)
            .validate()
                .responseJSON { response in
                  switch response.result {
                  case .success(let response):
                    print(response)
                  case .failure(let error):
                    print(error.localizedDescription)
                  }
        }
        
    }
    
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
        self.transcript = ""
        
        self.email = nil
        
        defaults.set(nil, forKey: "Email")
        
        signedIn = false
    }
}
