//
//  ErrorView.swift
//  Assignment
//
//  Created by Kamal Kishor on 08/12/24.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.dismiss) var dismiss
    
    let error: String
    @Binding var tryAgain: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.octagon.fill")
                .tint(.red)
            Text("Oops!!!")
                .font(.headline)
                .fontWeight(.bold)
            Text(error)
                .font(.body)
            Button("Try again") {
                tryAgain.toggle()
                dismiss()
            }
        }
    }
}

#Preview {
    ErrorView(error: "Error occurred", tryAgain: .constant(false))
}
