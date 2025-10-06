//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemIndigo
        return iv
    }()

    private let gradientOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        btn.layer.cornerRadius = 20
        return btn
    }()

    private let favoriteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        btn.layer.cornerRadius = 20
        return btn
    }()

    private let contentCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 12
        return view
    }()

    private let pointsBadge: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.layer.cornerRadius = 16
        return view
    }()

    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "2,500"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let pointsSubLabel: UILabel = {
        let label = UILabel()
        label.text = "points"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.9)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium Coffee Voucher"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Food & Beverage"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        return label
    }()

    private let availabilityLabel: UILabel = {
        let label = UILabel()
        label.text = "• 47 available"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGreen
        return label
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enjoy a premium coffee experience at any participating location. This voucher can be redeemed for any drink on our specialty menu, including lattes, cappuccinos, and seasonal favorites."
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let detailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()

    private let redeemButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Redeem Reward", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        btn.backgroundColor = .systemIndigo
        btn.layer.cornerRadius = 14
        btn.layer.shadowColor = UIColor.systemIndigo.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 8
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        addGradient()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerImageView)
        contentView.addSubview(gradientOverlay)
        contentView.addSubview(backButton)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(contentCard)

        contentCard.addSubview(pointsBadge)
        pointsBadge.addSubview(pointsLabel)
        pointsBadge.addSubview(pointsSubLabel)
        contentCard.addSubview(titleLabel)
        contentCard.addSubview(categoryLabel)
        contentCard.addSubview(availabilityLabel)
        contentCard.addSubview(divider)
        contentCard.addSubview(descriptionTitleLabel)
        contentCard.addSubview(descriptionLabel)
        contentCard.addSubview(detailsStack)
        contentCard.addSubview(redeemButton)

        setupConstraints()
        setupDetailItems()
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }

        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        gradientOverlay.snp.makeConstraints { make in
            make.edges.equalTo(headerImageView)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
        }

        contentCard.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(-40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        pointsBadge.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(48)
        }

        pointsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview().offset(-4)
        }

        pointsSubLabel.snp.makeConstraints { make in
            make.leading.equalTo(pointsLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview().offset(4)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsBadge.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
        }

        availabilityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLabel)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(8)
        }

        divider.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(1)
        }

        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        detailsStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        redeemButton.snp.makeConstraints { make in
            make.top.equalTo(detailsStack.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-32)
        }
    }

    private func setupDetailItems() {
        let details = [
            ("calendar", "Valid Until", "Dec 31, 2025"),
            ("location.fill", "Locations", "All participating stores"),
            ("clock.fill", "Redemption Time", "Anytime during business hours")
        ]

        for detail in details {
            let item = createDetailItem(icon: detail.0, title: detail.1, value: detail.2)
            detailsStack.addArrangedSubview(item)
        }
    }

    private func createDetailItem(icon: String, title: String, value: String) -> UIView {
        let container = UIView()

        let iconView = UIImageView()
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = .systemIndigo
        iconView.contentMode = .scaleAspectFit

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .systemGray

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        valueLabel.textColor = .label
        valueLabel.numberOfLines = 0

        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)

        iconView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(16)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        return container
    }

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 300)
        gradientOverlay.layer.addSublayer(gradientLayer)
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        redeemButton.addTarget(self, action: #selector(redeemTapped), for: .touchUpInside)
    }

    // MARK: - Animations
    private func animateIn() {
        contentCard.transform = CGAffineTransform(translationX: 0, y: 100)
        contentCard.alpha = 0

        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.contentCard.transform = .identity
            self.contentCard.alpha = 1
        }
    }

    // MARK: - Actions
    @objc private func backTapped() {
        dismiss(animated: true)
    }

    @objc private func favoriteTapped() {
        let isFavorited = favoriteButton.imageView?.image == UIImage(systemName: "heart.fill")
        let imageName = isFavorited ? "heart" : "heart.fill"

        UIView.animate(withDuration: 0.1) {
            self.favoriteButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8) {
                self.favoriteButton.transform = .identity
            }
        }
    }

    @objc private func redeemTapped() {
        UIView.animate(withDuration: 0.1) {
            self.redeemButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.redeemButton.transform = .identity
            }
        }

        // Show success feedback
        let alert = UIAlertController(title: "Success!", message: "Your reward has been redeemed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Preview Helper
#if DEBUG
import SwiftUI
struct RewardDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        RewardDetailViewControllerRepresentable()
            .ignoresSafeArea()
    }

    struct RewardDetailViewControllerRepresentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> ViewController {
            return ViewController()
        }

        func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    }
}
#endif
