//
//  PopupModalViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/04.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class PopupModalViewController: UIViewController {

    // MARK: - Properties
    private let dimmedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    private let backgroundModalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pancakes")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a popup modal message."
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let goToSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Primary Button", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 24
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()

    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureConstraints()
    }

}

// MARK: - Binding
private extension PopupModalViewController {
    func configureConstraints() {
        [dimmedBackgroundView, backgroundModalView, imageView, titleLabel, goToSettingsButton, closeButton].forEach {
            view.addSubview($0)
        }

        dimmedBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundModalView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundModalView.snp.top).offset(24)
            make.leading.trailing.equalTo(backgroundModalView).inset(32)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(backgroundModalView).inset(24)
        }

        goToSettingsButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(backgroundModalView).inset(24)
            make.height.equalTo(48)
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(goToSettingsButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(backgroundModalView).inset(24)
        }
    }

    func bind() {
        goToSettingsButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
//                guard let url = UIApplication.openSettingsURLString.url else { return }
//                UIApplication.shared.open(url)
//                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        closeButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
