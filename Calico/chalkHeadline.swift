//
//  chalkHeadline.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct chalkHeadline: View {
    var body: some View {
        Text("\(Date().formatted())")
            .foregroundColor(.white)
            .font(.system(.title3, design: .monospaced))
            .padding(.horizontal)
        Divider()
            .opacity(0)
            .background(
                Color.white.frame(width: UIScreen.main.bounds.width * 0.8, height: 1, alignment: .center)
                    .cornerRadius(15)
            )
    }
}

struct chalkHeadline_Previews: PreviewProvider {
    static var previews: some View {
        chalkHeadline()
    }
}
