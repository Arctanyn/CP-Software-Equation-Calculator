//
//  ScrollableText.swift
//  CP-Software
//
//  Created by Малиль Дугулюбгов on 21.02.2023.
//

import SwiftUI

struct ScrollableText: View {
    let scrollId: Int
    let text: String
    var textColor: Color = .primary
    
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(text)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(textColor)
                }
            }
        }
    }
}

struct ScrollableText_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableText(scrollId: 0, text: "Text", textColor: .primary)
    }
}
