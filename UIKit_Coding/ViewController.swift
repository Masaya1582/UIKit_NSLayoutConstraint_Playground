//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI

final class ViewController: UIViewController {

    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let phoneTextField = UITextField()
    private let bioTextView = UITextView()
    private let uploadResumeButton = UIButton(type: .system)
    private let agreeCheckbox = UIButton(type: .custom)
    private let agreeLabel = UILabel()
    private let submitButton = UIButton(type: .system)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Job Application"

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        let stack = UIStackView(arrangedSubviews: [
            makeTextField(nameTextField, placeholder: "Full Name"),
            makeTextField(emailTextField, placeholder: "Email"),
            makeTextField(phoneTextField, placeholder: "Phone"),
            makeTextView(bioTextView, placeholder: "Tell us about yourself..."),
            uploadResumeButton,
            makeAgreeSection(),
            submitButton
        ])
        stack.axis = .vertical
        stack.spacing = 24

        contentView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }

        styleButtons()
    }

    // MARK: - UI Components Setup
    private func makeTextField(_ textField: UITextField, placeholder: String) -> UIView {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        return textField
    }

    private func makeTextView(_ textView: UITextView, placeholder: String) -> UIView {
        let container = UIView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.separator.cgColor
        textView.text = placeholder
        textView.textColor = .placeholderText
        container.addSubview(textView)
        textView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return container
    }

    private func makeAgreeSection() -> UIView {
        let container = UIView()

        agreeCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        agreeCheckbox.tintColor = .label
        container.addSubview(agreeCheckbox)
        agreeCheckbox.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.size.equalTo(24)
        }

        agreeLabel.text = "I agree to the terms and conditions"
        agreeLabel.numberOfLines = 0
        agreeLabel.font = .systemFont(ofSize: 14)
        container.addSubview(agreeLabel)
        agreeLabel.snp.makeConstraints {
            $0.centerY.equalTo(agreeCheckbox)
            $0.leading.equalTo(agreeCheckbox.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }

        return container
    }

    private func styleButtons() {
        uploadResumeButton.setTitle("📎 Upload Resume", for: .normal)
        uploadResumeButton.setTitleColor(.systemBlue, for: .normal)
        uploadResumeButton.layer.borderColor = UIColor.systemBlue.cgColor
        uploadResumeButton.layer.borderWidth = 1
        uploadResumeButton.layer.cornerRadius = 8
        uploadResumeButton.contentEdgeInsets = .init(top: 12, left: 16, bottom: 12, right: 16)

        submitButton.setTitle("🚀 Submit Application", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemGreen
        submitButton.layer.cornerRadius = 8
        submitButton.contentEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}


struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
