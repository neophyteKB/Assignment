//
//  ErrorView.swift
//  Assignment
//
//  Created by Kamal Kishor on 08/12/24.
//

import SwiftUI

struct ErrorView: View {
    
    let error: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.octagon.fill")
                .tint(.red)
            Text("Oops!!!")
                .font(.headline)
                .fontWeight(.bold)
            Text(error)
                .font(.body)
        }
    }
}

#Preview {
    ErrorView(error: "Error occurred")
}
