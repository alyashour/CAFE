//
//  LineView.swift
//  CAFE
//
//  Created by Aly Ashour on 2024-03-13.
//

import SwiftUI

struct LineView: View {
    @ObservedObject var viewModel: LineViewModel = LineViewModel()
    
    var body: some View {
        HStack {
            TextField("Enter Input", text: $viewModel.input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit(viewModel.updateOutput)
            
            Spacer()
            
            Text(viewModel.output)
        }
        .padding()
    }
    
}
