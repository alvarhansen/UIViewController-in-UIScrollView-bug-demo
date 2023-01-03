//
//  ViewController.swift
//  VC in ScrollView POC
//
//  Created by Alvar Hansen on 02.01.2023.
//

import UIKit

// Toggle this boolean and rerun to see the difference.
var scrollViewShouldBeSecondChild = true

class ViewController: UIViewController {

    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        if scrollViewShouldBeSecondChild {
            let firstChild = UIView()
            view.addSubview(firstChild)
        }

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let scrollContent = UIView()
        scrollContent.translatesAutoresizingMaskIntoConstraints = false
        scrollContent.backgroundColor = .lightGray
        scrollView.addSubview(scrollContent)

        NSLayoutConstraint.activate([
            scrollContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContent.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        scrollContent.addSubview(stack)

        NSLayoutConstraint.activate([
            scrollContent.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            scrollContent.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            scrollContent.topAnchor.constraint(equalTo: stack.topAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])

        func addVC(color: UIColor, height: CGFloat, line: UInt = #line) {
            let child = ChildViewController()
            child.title = "\(line)"
            child.willMove(toParent: self)
            addChild(child)

            child.view.backgroundColor = color
            child.view.translatesAutoresizingMaskIntoConstraints = false
            child.view.heightAnchor.constraint(equalToConstant: height).isActive = true
            stack.addArrangedSubview(child.view)

            child.didMove(toParent: self)
        }

        addVC(color: .systemGreen, height: 300)
        addVC(color: .systemIndigo, height: 300)
        addVC(color: .systemTeal, height: 300)
        addVC(color: .systemBlue, height: 300)
        addVC(color: .systemOrange, height: 300)
    }

}

private class ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let content = UIView()
        content.layer.borderWidth = 1
        content.layer.borderColor = UIColor.red.cgColor
        view.addSubview(content)

        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            content.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            content.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            content.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(Self.self, #function, title!, view.safeAreaInsets)
    }
}
