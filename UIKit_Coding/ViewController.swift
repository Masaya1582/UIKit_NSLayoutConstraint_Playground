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

    private var tryCount = 0
    private let jackpotOdds = 319

    // UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🎰 PACHINKO 🎰"
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.textAlignment = .center
        label.textColor = .systemYellow
        return label
    }()

    private let machineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.systemYellow.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 8
        return view
    }()

    private let ballContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        view.layer.cornerRadius = 15
        return view
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Press START to play!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let oddsLabel: UILabel = {
        let label = UILabel()
        label.text = "Jackpot: 1/319"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .systemYellow
        return label
    }()

    private let tryCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Tries: 0"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .heavy)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0)

        view.addSubview(titleLabel)
        view.addSubview(machineView)
        machineView.addSubview(ballContainerView)
        machineView.addSubview(resultLabel)
        machineView.addSubview(oddsLabel)
        view.addSubview(tryCountLabel)
        view.addSubview(startButton)
        view.addSubview(resetButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }

        machineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(400)
        }

        ballContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }

        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(ballContainerView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        oddsLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        tryCountLabel.snp.makeConstraints { make in
            make.top.equalTo(machineView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }

        startButton.snp.makeConstraints { make in
            make.top.equalTo(tryCountLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }

        resetButton.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }

    private func setupActions() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        startButton.isEnabled = false
        tryCount += 1
        updateTryCount()

        // Button press animation
        UIView.animate(withDuration: 0.1, animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.startButton.transform = .identity
            }
        }

        // Clear previous balls
        ballContainerView.subviews.forEach { $0.removeFromSuperview() }

        // Animate balls dropping
        animateBalls {
            let isJackpot = self.checkJackpot()
            self.showResult(isJackpot: isJackpot)
            self.startButton.isEnabled = true
        }
    }

    @objc private func resetButtonTapped() {
        tryCount = 0
        updateTryCount()
        resultLabel.text = "Press START to play!"
        resultLabel.textColor = .white
        ballContainerView.subviews.forEach { $0.removeFromSuperview() }

        // Reset animation
        UIView.animate(withDuration: 0.2) {
            self.resetButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.resetButton.transform = .identity
            }
        }
    }

    private func animateBalls(completion: @escaping () -> Void) {
        let ballCount = 15
        let containerWidth = ballContainerView.bounds.width
        let containerHeight = ballContainerView.bounds.height

        for i in 0..<ballCount {
            let ball = UIView()
            ball.backgroundColor = .systemPink
            ball.layer.cornerRadius = 10
            ball.frame = CGRect(x: containerWidth / 2 - 10, y: -20, width: 20, height: 20)

            // Add shine effect
            let shineLayer = CAGradientLayer()
            shineLayer.frame = ball.bounds
            shineLayer.colors = [UIColor.white.withAlphaComponent(0.6).cgColor,
                                 UIColor.clear.cgColor]
            shineLayer.startPoint = CGPoint(x: 0, y: 0)
            shineLayer.endPoint = CGPoint(x: 1, y: 1)
            ball.layer.addSublayer(shineLayer)

            ballContainerView.addSubview(ball)

            let delay = Double(i) * 0.05
            let randomX = CGFloat.random(in: 20...(containerWidth - 40))
            let randomY = CGFloat.random(in: 20...(containerHeight - 40))

            UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
                ball.center = CGPoint(x: randomX, y: randomY)
                ball.transform = CGAffineTransform(rotationAngle: .pi * 2)
            }) { _ in
                if i == ballCount - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        completion()
                    }
                }
            }
        }
    }

    private func checkJackpot() -> Bool {
        return Int.random(in: 1...jackpotOdds) == 1
    }

    private func showResult(isJackpot: Bool) {
        if isJackpot {
            resultLabel.text = "🎊 JACKPOT! 🎊\nYOU WIN!"
            resultLabel.textColor = .systemYellow
            celebrateJackpot()
        } else {
            resultLabel.text = "Try Again!"
            resultLabel.textColor = .systemRed
        }

        UIView.transition(with: resultLabel, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }

    private func celebrateJackpot() {
        // Flash animation
        UIView.animate(withDuration: 0.2, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.machineView.backgroundColor = UIColor.systemYellow
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.machineView.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.3) {
                self.machineView.backgroundColor = UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0)
            }
        }

        // Confetti effect
        createConfetti()
    }

    private func createConfetti() {
        for _ in 0..<30 {
            let confetti = UIView()
            confetti.backgroundColor = [UIColor.systemRed, .systemYellow, .systemGreen, .systemBlue, .systemPink].randomElement()
            confetti.frame = CGRect(x: CGFloat.random(in: 0...view.bounds.width), y: -20, width: 10, height: 10)
            confetti.layer.cornerRadius = 5
            view.addSubview(confetti)

            UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseIn, animations: {
                confetti.frame.origin.y = self.view.bounds.height + 20
                confetti.transform = CGAffineTransform(rotationAngle: .pi * 4)
            }) { _ in
                confetti.removeFromSuperview()
            }
        }
    }

    private func updateTryCount() {
        tryCountLabel.text = "Tries: \(tryCount)"

        UIView.animate(withDuration: 0.2) {
            self.tryCountLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.tryCountLabel.transform = .identity
            }
        }
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
