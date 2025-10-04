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

final class ViewController: UIViewController {

    private let showPopupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Popup Modal", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        return button
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        bind()
    }

    private func setupConstraints() {
        view.addSubview(showPopupButton)
        showPopupButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(48)
        }
    }
}

private extension ViewController {
    func bind() {
        showPopupButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let controller = PopupModalViewController()
                self?.present(controller, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
