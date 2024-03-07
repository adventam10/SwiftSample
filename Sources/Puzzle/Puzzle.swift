//
//  Puzzle.swift
//  SwiftSample
//
//  Created by am10 on 2024/03/07.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            Color.green
                .frame(width: 300, height: 300)
            PuzzleView()
                .frame(width: 300, height: 300)
        }
    }
}

struct PuzzleView: View {

    // ここで画像設定
    private let image = UIImage(named: "target")!
    private let pieceSize: CGFloat = 100
    @State private var positions: [CGPoint] = .init(repeating: .zero, count: 8)
    @State private var images: [UIImage] = .init(repeating: .init(systemName: "pencil")!, count: 8)

    var drag: some Gesture {
        DragGesture()
            .onChanged{ value in
                func _calculateDirection(value: DragGesture.Value) -> Direction {
                    let currentLocation = value.location
                    let preLocation = value.startLocation
                    let x = currentLocation.x - preLocation.x
                    let y = currentLocation.y - preLocation.y
                    let direction: Direction
                    if abs(x) > abs(y) {
                        direction = x < 0 ? .left : .right
                    } else {
                        direction = y < 0 ? .up : .down
                    }
                    return direction
                }

                guard let targetIndex = positions.firstIndex (where: {
                    CGRect(origin: .init(x: $0.x - pieceSize/2, y:  $0.y - pieceSize/2), size: .init(width: pieceSize, height: pieceSize)).contains(value.startLocation)
                }) else {
                    return
                }

                var position = positions[targetIndex]
                switch _calculateDirection(value: value) {
                case .up:
                    position.y -= pieceSize
                case .down:
                    position.y += pieceSize
                case .right:
                    position.x += pieceSize
                case .left:
                    position.x -= pieceSize
                }
                let fullRect = CGRect(origin: .zero, size: .init(width: pieceSize*3, height: pieceSize*3))
                if !fullRect.contains(position) {
                    return
                }
                let pieceRects = positions.map { CGRect(origin: .init(x: $0.x - pieceSize/2, y:  $0.y - pieceSize/2), size: .init(width: pieceSize, height: pieceSize)) }
                if pieceRects.contains(where: { $0.contains(position) }) {
                    return
                }
                positions[targetIndex] = position
            }
    }

    var body: some View {
        ZStack {
            Image(uiImage: images[0])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[0])

            Image(uiImage: images[1])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[1])

            Image(uiImage: images[2])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[2])

            Image(uiImage: images[3])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[3])

            Image(uiImage: images[4])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[4])

            Image(uiImage: images[5])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[5])

            Image(uiImage: images[6])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[6])

            Image(uiImage: images[7])
                .resizable()
                .frame(width: pieceSize, height: pieceSize)
                .position(positions[7])
        }
        .gesture(drag)
        .onAppear {
            setupPuzzle()
        }
    }

    private func setupPuzzle() {
        var imageIndexes = [Int]()
        while true {
            if let indexes = makeIndexes() {
                imageIndexes = indexes
                break
            }
        }

        let width = image.size.width/3
        let height = image.size.height/3
        var images = [UIImage]()
        for i in 0...2 {
            let x = width * CGFloat(i)
            for j in 0...2 {
                let y = height * CGFloat(j)
                let img = image.trimming(rect: .init(origin: .init(x: x, y: y), size: .init(width: width, height: height)))
                images.append(img)
            }
        }

        var results = [Int]()
        var index = 0
        for i in 0...2 {
            let x = pieceSize * CGFloat(i)
            for j in 0...2 {
                let y = pieceSize * CGFloat(j)
                if index < positions.count {
                    positions[index] = .init(x: x + pieceSize/2, y: y + pieceSize/2)
                    let imageIndex = imageIndexes[index]
                    self.images[index] = images[imageIndex]
                    results.append(imageIndex)
                }
                index += 1
            }
        }
    }

    private func makeIndexes() -> [Int]? {
        let startIndexes = [0, 1, 2, 3, 4, 5, 6, 7]
        var imageIndexes = startIndexes.shuffled()
        let result = imageIndexes + [8]

        var count = 0
        for i in 0..<imageIndexes.count-1 {
            let t1 = imageIndexes[i]
            let t2 = startIndexes[i]
            if t1 == t2 {
                continue
            } else {
                let index = imageIndexes.firstIndex(of: t2)!
                imageIndexes[i] = t2
                imageIndexes[index] = t1
                count += 1
            }
        }
        return count%2 == 0 ? result : nil
    }
}
