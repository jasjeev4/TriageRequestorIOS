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
                
                ProfileButtonView(imageName: "Jasjeev")
                
                Spacer()
                
                ProfileButtonView(imageName: "Justin")
                
                Spacer()
            }
            
            HStack{
                Spacer()
                
                ProfileButtonView(imageName: "Marc")
                
                Spacer()
                
                ProfileButtonView(imageName: "Tara")
                
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
