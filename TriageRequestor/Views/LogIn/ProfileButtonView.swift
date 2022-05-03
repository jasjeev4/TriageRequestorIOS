//
//  ProfileImageView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct ProfileButtonView: View {
    @EnvironmentObject var viewModel: RequestorViewModel
    
    @State var imageName: String
    
    var body: some View {
        Button(action: {
            // called after button tap complete
            viewModel.user = imageName
            
            viewModel.loginEmail(email: nameToEmail[imageName]!)
        }) {
            Image(imageName)
                .resizable()
                .frame(width: 120.0, height: 120.0)
                .padding(30)
        }
    }
}

struct ProfileButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtonView(imageName: "Jasjeev")
    }
}
