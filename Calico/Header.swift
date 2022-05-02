//
//  Header.swift
//  Calico
//
//  Created by Luke Drushell on 4/30/22.
//

import SwiftUI

struct Header: View {
    
    @State var openingAnimation: CGFloat = 0
    
    var body: some View {
        fancyTitle(title: "Calico")
        HStack {
            Text("You're doing great today!")
                .padding(.horizontal)
                .font(.system(.title3, design: .monospaced))
                .foregroundColor(.white)
                .mask({
                    Color.white
                        .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                        .position(x: openingAnimation - (UIScreen.main.bounds.width / 2) - 100)
                })
                .overlay(content: {
                    ZStack {
                        Image("catt")
                            .resizable()
                            .frame(width: 100, height: 75, alignment: .center)
                            .position(x: -50 + openingAnimation, y: 15)
                    }
                })
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        withAnimation(.linear(duration: 1.5), {
                            openingAnimation = UIScreen.main.bounds.width + 100
                        })
                    })
                })
            Spacer()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Header()
            }
        }
    }
}

func timeSymbol() -> String {
    var output = "sun.max.fill"
    let sunrise: Date = Calendar.current.date(bySettingHour: 4, minute: 59, second: 59, of: Date())!
    let early: Date = Calendar.current.date(bySettingHour: 6, minute: 59, second: 59, of: Date())!
    let noon: Date = Calendar.current.date(bySettingHour: 11, minute: 59, second: 59, of: Date())!
    let evening: Date = Calendar.current.date(bySettingHour: 17, minute: 59, second: 59, of: Date())!
    let night: Date = Calendar.current.date(bySettingHour: 20, minute: 59, second: 59, of: Date())!
    let time = Date()
    if time > night {
        output = "moon.zzz.fill"
    } else if time > evening {
        output = "sunset.fill"
    } else if time > noon {
        output = "sun.max.fill"
    } else if time > early {
        output = "sun.min.fill"
    } else if time > sunrise {
        output = "sunrise.fill"
    } else {
        output = "moon.zzz.fill"
    }
    return output
}
