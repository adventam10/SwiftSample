//
//  EasterEgg.swift
//  SwiftSample
//
//  Created by am10 on 2024/03/06.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        PageView(pages: [
            AnyView(Color(uiColor: .systemBackground)),
            AnyView(
                HStack {
                    // なにか画像設定
                    Image("target")
                        .resizable()
                        .frame(width: 50, height: 50)

                    Text("わたしがつくりました")
                }
            )
        ])
        .frame(height: 50)
    }
}

struct PageView: UIViewControllerRepresentable {

    var pages: [AnyView]

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([context.coordinator.controllers.first!], direction: .forward, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource {

        private var parent: PageView
        var controllers: [UIViewController]

        private func validIndex(_ index: Int) -> Int? {
            if controllers.count > index && index >= 0 {
                return index
            }
            return nil
        }

        init(parent: PageView) {
            self.parent = parent
            self.controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = controllers.firstIndex(of: viewController),
                  let index = validIndex(currentIndex + 1) else {
                return nil
            }
            return controllers[index]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = controllers.firstIndex(of: viewController),
                  let index = validIndex(currentIndex - 1) else {
                return nil
            }
            return controllers[index]
        }
    }
}
