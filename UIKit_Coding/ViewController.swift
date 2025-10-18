//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray5
        return iv
    }()

    private let favoriteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        btn.tintColor = .systemRed
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 4
        btn.layer.shadowOpacity = 0.1
        return btn
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.numberOfLines = 0
        lbl.text = "Premium Wireless Headphones"
        return lbl
    }()

    private let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 28, weight: .heavy)
        lbl.textColor = .systemBlue
        lbl.text = "$299.99"
        return lbl
    }()

    private let originalPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .systemGray
        let attributedText = NSAttributedString(
            string: "$399.99",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        lbl.attributedText = attributedText
        return lbl
    }()

    private let discountBadge: UILabel = {
        let lbl = UILabel()
        lbl.text = "-25%"
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .white
        lbl.backgroundColor = .systemRed
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 4
        lbl.clipsToBounds = true
        return lbl
    }()

    private let ratingView = UIView()
    private let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "4.8"
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        return lbl
    }()

    private let starImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star.fill")
        iv.tintColor = .systemYellow
        return iv
    }()

    private let reviewCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "(1,234 reviews)"
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .systemGray
        return lbl
    }()

    private let descriptionTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Description"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()

    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .systemGray
        lbl.numberOfLines = 0
        lbl.text = "Experience premium sound quality with active noise cancellation. These wireless headphones feature 30-hour battery life, comfortable ear cushions, and crystal-clear audio for music and calls."
        return lbl
    }()

    private let featuresTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Features"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()

    private let featuresStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        return sv
    }()

    private let colorTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Color"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()

    private let colorStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.distribution = .fillEqually
        return sv
    }()

    private let addToCartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add to Cart", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 12
        return btn
    }()

    private let buyNowButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Buy Now", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        btn.layer.cornerRadius = 12
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(originalPriceLabel)
        contentView.addSubview(discountBadge)

        ratingView.addSubview(starImageView)
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(reviewCountLabel)
        contentView.addSubview(ratingView)

        contentView.addSubview(descriptionTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(featuresTitleLabel)
        contentView.addSubview(featuresStackView)
        contentView.addSubview(colorTitleLabel)
        contentView.addSubview(colorStackView)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(buyNowButton)

        // Add sample features
        addFeature(icon: "checkmark.circle.fill", text: "Active Noise Cancellation")
        addFeature(icon: "battery.100", text: "30-Hour Battery Life")
        addFeature(icon: "wifi", text: "Bluetooth 5.0 Connectivity")
        addFeature(icon: "mic.fill", text: "Built-in Microphone")

        // Add color options
        addColorOption(color: .black, isSelected: true)
        addColorOption(color: .systemBlue, isSelected: false)
        addColorOption(color: .systemGray, isSelected: false)
        addColorOption(color: .systemRed, isSelected: false)

        // Set placeholder image
        imageView.image = UIImage(systemName: "headphones")
        imageView.tintColor = .systemGray3
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(16)
            make.trailing.equalTo(imageView).offset(-16)
            make.width.height.equalTo(40)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
        }

        originalPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
            make.centerY.equalTo(priceLabel)
        }

        discountBadge.snp.makeConstraints { make in
            make.leading.equalTo(originalPriceLabel.snp.trailing).offset(8)
            make.centerY.equalTo(priceLabel)
            make.width.equalTo(50)
            make.height.equalTo(24)
        }

        ratingView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }

        starImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }

        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }

        reviewCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(ratingLabel.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        featuresTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        featuresStackView.snp.makeConstraints { make in
            make.top.equalTo(featuresTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        colorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(featuresStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        colorStackView.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(colorStackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }

        buyNowButton.snp.makeConstraints { make in
            make.top.equalTo(addToCartButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        buyNowButton.addTarget(self, action: #selector(buyNowTapped), for: .touchUpInside)
    }

    // MARK: - Helper Methods
    private func addFeature(icon: String, text: String) {
        let containerView = UIView()

        let iconView = UIImageView()
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = .systemGreen

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 15)

        containerView.addSubview(iconView)
        containerView.addSubview(label)

        iconView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }

        label.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.trailing.top.bottom.equalToSuperview()
        }

        featuresStackView.addArrangedSubview(containerView)
    }

    private func addColorOption(color: UIColor, isSelected: Bool) {
        let button = UIButton(type: .custom)
        button.backgroundColor = color
        button.layer.cornerRadius = 25
        button.layer.borderWidth = isSelected ? 3 : 0
        button.layer.borderColor = UIColor.systemBlue.cgColor

        if isSelected {
            let checkmark = UIImageView(image: UIImage(systemName: "checkmark"))
            checkmark.tintColor = .white
            button.addSubview(checkmark)
            checkmark.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalTo(20)
            }
        }

        colorStackView.addArrangedSubview(button)
    }

    // MARK: - Actions
    @objc private func favoriteTapped() {
        favoriteButton.isSelected.toggle()
        UIView.animate(withDuration: 0.2) {
            self.favoriteButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.favoriteButton.transform = .identity
            }
        }
    }

    @objc private func addToCartTapped() {
        let alert = UIAlertController(title: "Added to Cart", message: "Item has been added to your cart", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func buyNowTapped() {
        let alert = UIAlertController(title: "Purchase", message: "Proceeding to checkout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
