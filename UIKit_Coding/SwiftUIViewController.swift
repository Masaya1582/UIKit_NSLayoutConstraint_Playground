//
//  SwiftUIViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SwiftUI

struct SwiftUIViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let viewController = storyboard.instantiateInitialViewController() as? ViewController
        else {
            fatalError("Cannot load ViewController from Main storyboard.")
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

// Xibの場合はこっち
//    struct SwiftUIViewController: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            let viewController = UIViewController(nibName: "<#Name#>", bundle: nil)
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//    }
