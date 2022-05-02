//
//  ListView.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct ListViewLarge: View {
    
    @Binding var editingItems: Bool
    @Binding var scaled: Bool
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @State var completed: Bool = false
    @State var items: [listItems] = [listItems(text: "Drink some water today", completed: false), listItems(text: "Do some programming on Watchable with an API for getting movie info", completed: false), listItems(text: "Study for AP Tests", completed: false)]
    
    @State var newItem: listItems = listItems(text: "", completed: false)
    
    @State var pageState: Int = 0
    //0 = adding, 1 = drawing, 2 = erasing
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, Color(uiColor: UIColor.systemGreen)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: width, height: height + 50, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(4)
            ScrollView {
                VStack(alignment: .leading) {
                    chalkHeadline()
                    ForEach(items.indices, id: \.self, content: { index in
                        if pageState != 2 {
                            Button {
                                items[index].completed.toggle()
                            } label: {
                                listPage(title: items[index].text, completed: items[index].completed)
                                    .frame(width: width * 0.95, alignment: .center)
                            }
                        } else {
                            HStack {
                                listPageDelete(title: items[index].text)
                                    .frame(width: width * 0.8, alignment: .center)
                                Button {
                                    items.remove(at: index)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .frame(width: 22, height: 22, alignment: .center)
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 28)
                            } .frame(width: width * 0.95, alignment: .center)
                        }
                    })
                    if pageState == 0 {
                        TextField("New Goal", text: $newItem.text)
                            .accentColor(.white)
                            .font(.system(.headline, design: .monospaced))
                            //.bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                            .foregroundColor(.white)
                            .padding()
                            .onSubmit {
                                if newItem.text != "" {
                                    items.append(newItem)
                                    newItem = listItems(text: "", completed: false)
                                }
                            }
                    }
                    Spacer()
                } .frame(width: width * 0.95, alignment: .center)
                    .padding(.top, 150)
            } .overlay(content: {
                VStack(alignment: .leading) {
                    Button {
                        editingItems = false
                        withAnimation(.easeOut(duration: 0.2), {
                            scaled = false
                        })
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 18, alignment: .center)
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(.top, 85)
                    }
                    Spacer()
                    HStack {
                        Button {
                            pageState = 2
                        } label: {
                            Text("🧻")
                                .font(.system(size: 70))
                        }
                            .padding(50)
                        Button {
                            pageState = 0
                        } label: {
                            Text("✏️")
                                .font(.system(size: 60))
                                .rotationEffect(Angle(radians: 1.5))
                        }
                            .padding(50)
                        
                    }
                }
            })
        }
    }
}

struct ListViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        ListViewLarge(editingItems: .constant(true), scaled: .constant(true))
    }
}

struct listPageDelete: View {
    let title: String
    var body: some View {
        HStack {
            Text("\(title)")
                .font(.system(.headline, design: .monospaced))
                //.bold()
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .minimumScaleFactor(0.9)
                .foregroundColor(.white)
                .padding()
            Spacer()
        }
    }
}
