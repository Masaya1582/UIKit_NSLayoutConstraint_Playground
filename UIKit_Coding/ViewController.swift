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
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Big Bro"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer 💻 | Swift Wizard 🧙‍♂️"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let followButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Follow", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 16
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()

    private let statsStackView: UIStackView = {
        let followersLabel = UILabel()
        followersLabel.text = "1,250\nFollowers"
        followersLabel.numberOfLines = 2
        followersLabel.textAlignment = .center

        let postsLabel = UILabel()
        postsLabel.text = "68\nPosts"
        postsLabel.numberOfLines = 2
        postsLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [followersLabel, postsLabel])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.distribution = .fillEqually
        return stack
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }

    private func setupConstraints() {
        [profileImageView, nameLabel, bioLabel, followButton, statsStackView].forEach {
            view.addSubview($0)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        profileImageView.layer.cornerRadius = 48

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(40)
        }

        followButton.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(36)
        }

        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(followButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
