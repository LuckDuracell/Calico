//
//  ListView.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct ListView: View {
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @State var completed: Bool = false
    @State var items: [listItems] = [listItems(text: "Drink some water today", completed: false), listItems(text: "Do some programming", completed: false), listItems(text: "Text friends", completed: false)]
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, Color(uiColor: UIColor.systemGreen)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: width * 0.9, height: 500, alignment: .center)
                .border(.brown, width: 9)
                .cornerRadius(4)
            VStack(alignment: .leading) {
                chalkHeadline()
                ForEach(items.indices, id: \.self, content: { index in
                    Button {
                        items[index].completed.toggle()
                    } label: {
                        listPage(title: items[index].text, completed: items[index].completed)
                            .frame(width: width * 0.85, height: 50, alignment: .center)
                    }
                })
                Spacer()
            } .frame(width: width * 0.85, height: 450, alignment: .center)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


struct listPage: View {
    let title: String
    let completed: Bool
    var body: some View {
        HStack {
            Text("\(title)")
                .font(.system(.headline, design: .monospaced))
                .bold()
                .foregroundColor(.white)
                .padding()
            Spacer()
            Circle()
                .strokeBorder(Color.white, lineWidth: 3)
                .background(Circle().fill(completed ? .white : .clear))
                .frame(width: 22, height: 22, alignment: .center)
                .padding()
        }
    }
}

struct listItems {
    var text: String
    var completed: Bool
}
