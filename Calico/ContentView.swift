//
//  ContentView.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct ContentView: View {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @State var scaled: Bool = false
    @State var editingItems: Bool = false
    
    @State var catPet = false
    
    @State var openingAnimation: CGFloat = -50
    
    var body: some View {
        ZStack {
            if editingItems != true {
            Image("redbricks")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.bottom)
                .overlay(content: {
                    VStack {
                       Window()
                    Spacer()
                    }
                    .edgesIgnoringSafeArea(.all)
                })
            }
            VStack {
                Header()
                    .frame(width: width, alignment: .center)
                ListView()
                    .frame(width: width, alignment: .center)
                    .padding(.top, 40)
                    .overlay(alignment: .bottomTrailing, content: {
                        Button {
                            withAnimation(.easeIn(duration: 0.3), {
                                scaled.toggle()
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                editingItems.toggle()
                            })
                        } label: {
                            Text("✎")
                                .font(.system(size: 70, design: .rounded))
                                .bold()
                                .foregroundColor(.white)
                                .rotationEffect(Angle(radians: 2))
                        } .padding(30)
                            .padding(.trailing)
                    })
                    .blur(radius: scaled ? 6 : 0)
                Spacer()
            }
            .overlay(alignment: .bottom, content: {
                HStack {
                    Button {
                        catPet.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            catPet.toggle()
                        })
                    } label: {
                        Image("catsitting")
                            .resizable()
                            .frame(width: 150, height: 150, alignment: .center)
                    }
                    Spacer()
                    Text(catPet ? "purr" : "")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, -30)
                    Spacer()
                } .padding(.horizontal, 50)
                    .position(x: 190, y: height - openingAnimation)
            })
            .scaleEffect(scaled ? 2 : 1)
            if editingItems {
                ListViewLarge(editingItems: $editingItems, scaled: $scaled)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                withAnimation(.spring(), {
                    openingAnimation = 100
                })
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


