//
//  RecordButtonView.swift
//  TriageRequestor
//
//  Created by Jasjeev Anand on 03/05/22.
//

import SwiftUI

struct RecordButtonView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var buttonTapped: Bool = false
    
    var body: some View {
        
        Button(action: {
            // called after button tap complete
            self.buttonTapped = false
        }) {
            Image(systemName: "mic.circle.fill")
                .resizable()
                .frame(width: 75.0, height: 75.0)
                .clipShape(Circle())
            
        }
        .foregroundColor(Color.black)
        .simultaneousGesture((LongPressGesture(minimumDuration: 0.1).onEnded({ _ in
            // actions during button hold
            self.buttonTapped = true
        })))
    }
}

struct RecordButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RecordButtonView()
    }
}
