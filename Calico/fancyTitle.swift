//
//  fancyTitle.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct fancyTitle: View {
    let title: String
    var body: some View {
        HStack {
            Text("\(title)")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
                .foregroundColor(.white)
                .padding()
            Spacer()
            Image(systemName: timeSymbol())
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55, alignment: .center)
                .foregroundColor(timeSymbol().contains("sun") ? .yellow : .white)
                .padding()
                .padding(.trailing, 25)
                .shadow(color: timeSymbol().contains("sun") ? .yellow.opacity(0.8) : .white.opacity(0.7), radius: 20, x: 0, y: 0)
        }
    }
}

struct fancyTitle_Previews: PreviewProvider {
    static var previews: some View {
        fancyTitle(title: "Calico")
    }
}
