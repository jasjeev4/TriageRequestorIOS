//
//  ProfileImageView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct ProfileImageView: View {
    @State var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 120.0, height: 120.0)
            .padding(30)
            .cornerRadius(15)
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(imageName: "Jasjeev")
    }
}
