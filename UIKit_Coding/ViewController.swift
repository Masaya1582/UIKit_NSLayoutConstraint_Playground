//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.2
        iv.layer.shadowOffset = CGSize(width: 0, height: 4)
        iv.layer.shadowRadius = 8
        iv.backgroundColor = .systemGray5
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()

    private let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .tertiaryLabel
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()

    private let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Notes"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let memoTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16, weight: .regular)
        tv.textColor = .label
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        tv.backgroundColor = .secondarySystemBackground
        tv.layer.cornerRadius = 10
        return tv
    }()

    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        populateSampleData()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Book Memo"

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(ratingStackView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(memoTitleLabel)
        contentView.addSubview(memoTextView)
        contentView.addSubview(tagsLabel)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        coverImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(240)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingStackView)
            make.trailing.equalToSuperview().inset(20)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }

        memoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        tagsLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-30)
        }
    }

    // MARK: - Data Population
    private func populateSampleData() {
        // Set sample cover image (placeholder)
        coverImageView.backgroundColor = .systemIndigo
        let imageLabel = UILabel()
        imageLabel.text = "📚"
        imageLabel.font = .systemFont(ofSize: 60)
        imageLabel.textAlignment = .center
        coverImageView.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        titleLabel.text = "The Art of Computer Programming"
        authorLabel.text = "by Donald Knuth"

        // Create star rating
        for i in 0..<5 {
            let star = UIImageView()
            star.image = UIImage(systemName: i < 4 ? "star.fill" : "star")
            star.tintColor = .systemYellow
            star.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
            ratingStackView.addArrangedSubview(star)
        }

        dateLabel.text = "Oct 21, 2025"

        memoTextView.text = """
        This comprehensive work on algorithms and data structures is truly a masterpiece of computer science literature. Knuth's rigorous approach to analyzing algorithms provides deep insights into their efficiency and behavior.
        
        Key takeaways:
        • Mathematical analysis is crucial for understanding algorithm performance
        • The importance of choosing the right data structure for the problem
        • Historical context enriches technical understanding
        
        I particularly appreciated the detailed discussion of sorting algorithms and their comparative performance. The exercises are challenging but rewarding, pushing readers to think deeply about the material.
        
        This is a book to return to repeatedly throughout one's career.
        """

        tagsLabel.text = "#ComputerScience #Algorithms #Programming #Classic"
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
