//
//  Header.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 01/07/2024.
//

import SwiftUI

/// View that centers the content in the middle of the screen horizontally
struct Header<T>: View where T: View {
    var content: () -> T
    
    init(@ViewBuilder content: @escaping () -> T) {
        self.content = content
    }
    
    var body: some View {
        HStack {
            Spacer()
            content()
            Spacer()
        }
    }
}
