//
//  ContentView.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("beige"), .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                Header()
                Divider()
                    .padding(30)
                ListView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


