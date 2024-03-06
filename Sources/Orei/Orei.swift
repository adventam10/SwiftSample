//
//  Orei.swift
//  SwiftSample
//
//  Created by am10 on 2024/03/06.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            HStack {
                Orei()
                    .frame(width: 200, height: 200)
                    .background(Color.black)

                Orei(lineWidth: 1, circleSpace: 8)
                    .frame(width: 100, height: 100)
                    .background(Color.black)
            }
            Orei(circleSpace: 20)
                .frame(width: 300, height: 400)
                .background(Color.black)
        }
    }
}

struct Orei: View {

    var lineWidth: CGFloat = 3
    var circleSpace: CGFloat = 10
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let radius = min(geometry.size.width, geometry.size.height)/2 - lineWidth/2
                let r: CGFloat = radius - circleSpace
                let r2: CGFloat = radius
                let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
                path.addArc(center: center, radius: r, startAngle: .init(degrees: 0), endAngle: .init(degrees: 360), clockwise: true)
                path.addArc(center: center, radius: r2, startAngle: .init(degrees: 0), endAngle: .init(degrees: 360), clockwise: true)
                path.move(to: CGPoint(x: center.x + sin(0)*r, y: center.y + cos(0)*r))
                path.addLine(to: CGPoint(x: center.x + sin(.pi*(3/4) * -1)*r, y: center.y + cos(.pi*(3/4) * -1)*r))
                path.addLine(to: CGPoint(x: center.x + sin(.pi/4)*r, y: center.y + cos(.pi/4)*r))
                path.addLine(to: CGPoint(x: center.x + sin(.pi)*r, y: center.y + cos(.pi)*r))
                path.addLine(to: CGPoint(x: center.x + sin(.pi/4 * -1)*r, y: center.y + cos(.pi/4 * -1)*r))
                path.addLine(to: CGPoint(x: center.x + sin(.pi*(3/4))*r, y: center.y + cos(.pi*(3/4))*r))
                path.addLine(to: CGPoint(x: center.x + sin(0)*r, y: center.y + cos(0)*r))
                path.closeSubpath()
                for i in 1..<60 {
                    let n: CGFloat = CGFloat(i) * .pi * (6/90)
                    path.move(to: CGPoint(x: center.x + sin(n)*r, y: center.y + cos(n)*r))
                    path.addLine(to: CGPoint(x: center.x + sin(n)*r2, y: center.y + cos(n)*r2))
                }
            }
            .stroke(style: .init(lineWidth: lineWidth, lineJoin: .bevel))
            .fill(Color.green)
        }
    }
}
