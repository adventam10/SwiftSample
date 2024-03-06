//
//  Confetti.swift
//  SwiftSample
//
//  Created by am10 on 2024/03/06.
//

import SwiftUI
import SceneKit

struct ContentView: View {

    @StateObject private var scene = ConfettiScene()

    var body: some View {
        ZStack {
            SceneView(scene: scene)
            Button("Confetti") {
                scene.showConfetti()
            }
        }
    }
}

final class ConfettiScene: SCNScene, ObservableObject {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init() {
        super.init()
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, -10, 10)
        rootNode.addChildNode(cameraNode)
    }

    func showConfetti() {
        let particle = SCNParticleSystem()
        particle.birthRate = 50
        particle.birthDirection = .random
        particle.particleLifeSpan = 20
        particle.particleAngularVelocity = 300
        particle.emitterShape = SCNBox(width: 10, height: 0, length: 5, chamferRadius: 0)
        particle.particleColor = .red
        particle.particleSize = 0.1
        particle.particleColorVariation = .init(x: 180, y: 0.1, z: 0.1, w: 0)
        particle.imageSequenceAnimationMode = .repeat
        particle.blendMode = .alpha
        particle.orientationMode = .free
        particle.sortingMode = .distance
        particle.isAffectedByGravity = true
        particle.particleBounce = 0.7
        particle.dampingFactor = 5
        rootNode.addParticleSystem(particle)
    }
}
