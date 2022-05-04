//
//  APIModel.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import Foundation

private var apiEndpoint = "triage.sitfortoday.com/fallen"

enum ApiRoutes: String {
    case postDesireRoute = "request"
    //case postSensors = "sensors"
}

struct TriageApi {
    static var user_id = ""
    
    static var session_token = ""
    
    static var auth: String {
        user_id + ":" + session_token
    }
    
    static func endpoint() -> String {
        return "https://" + apiEndpoint
    }
    
    static func postDesire() -> String {
        return endpoint() + "/" + ApiRoutes.postDesireRoute.rawValue
    }

}
