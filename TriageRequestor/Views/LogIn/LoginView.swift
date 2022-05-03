//
//  LoginView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            HStack{
                Spacer()
                
                ProfileImageView(imageName: "Jasjeev")
                
                Spacer()
                
                ProfileImageView(imageName: "Justin")
                
                Spacer()
            }
            
            HStack{
                Spacer()
                
                ProfileImageView(imageName: "Marc")
                
                Spacer()
                
                ProfileImageView(imageName: "Tara")
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
