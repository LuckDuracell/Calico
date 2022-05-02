//
//  Window.swift
//  Calico
//
//  Created by Luke Drushell on 5/1/22.
//

import SwiftUI

struct Window: View {
    
    @State var circles: [circleInfo] = []
    @State var brownCircles: [circleInfo] = []
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        LinearGradient(colors: [.blue, .white], startPoint: .bottomLeading, endPoint: .topTrailing)
        .frame(width: UIScreen.main.bounds.width + 100, height: 200, alignment: .topTrailing)
        .overlay(content: {
            ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(.ultraThinMaterial)
                .frame(width: UIScreen.main.bounds.width + 100, height: 200, alignment: .topTrailing)
                ForEach(circles, id: \.self, content: { circle in
                    Circle()
                        .foregroundColor(.clear)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .frame(width: circle.size, height: circle.size, alignment: .center)
                        .position(x: circle.x, y: circle.y)
                        .blur(radius: 3)
                })
//                ForEach(brownCircles, id: \.self, content: { circle in
//                    Circle()
//                        .foregroundColor(.brown.opacity((circle.size / CGFloat(25))))
//                        .background(.ultraThinMaterial)
//                        .clipShape(Circle())
//                        .frame(width: circle.size, height: circle.size, alignment: .center)
//                        .position(x: circle.x, y: circle.y)
//                        .blur(radius: )
//                })
            }
        })
        .overlay(content: {
            VStack {
                Spacer()
                LinearGradient(colors: [.clear, .black.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                    .frame(width: width, height: 40, alignment: .center)
            }
        })
        .border(width: 20, edges: [.bottom], color: Color.init(red: 0.95, green: 0.95, blue: 1))
        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 5)
        .padding(.top, 10)
        .onAppear(perform: {
            if circles.isEmpty {
                for _ in 0...Int.random(in: 3...8) {
                    circles.append(circleInfo(x: CGFloat.random(in: 0...(width + 100)), y: CGFloat.random(in: 0...200), size: CGFloat.random(in: 3...18)))
                }
            }
            if brownCircles.isEmpty {
                for _ in 0...Int.random(in: 3...7) {
                    brownCircles.append(circleInfo(x: CGFloat.random(in: 0...(width + 100)), y: CGFloat.random(in: 0...200), size: CGFloat.random(in: 3...18)))
                }
            }
        })
    }
}

struct Window_Previews: PreviewProvider {
    static var previews: some View {
        Window()
    }
}

struct circleInfo: Hashable {
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
}


extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}
