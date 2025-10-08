//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI

// MARK: - Device Model
struct Device {
    let name: String
    let model: String
    let systemName: String
    let icon: String
    let color: UIColor
    let battery: Int?
    let isConnected: Bool
}

// MARK: - Device Cell
class DeviceCell: UITableViewCell {
    static let identifier = "DeviceCell"

    private let containerView = UIView()
    private let iconContainer = UIView()
    private let iconLabel = UILabel()
    private let nameLabel = UILabel()
    private let modelLabel = UILabel()
    private let statusLabel = UILabel()
    private let batteryIcon = UILabel()
    private let batteryLabel = UILabel()
    private let chevronIcon = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.08

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        }

        // Icon Container
        containerView.addSubview(iconContainer)
        iconContainer.layer.cornerRadius = 12

        iconContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }

        // Icon
        iconContainer.addSubview(iconLabel)
        iconLabel.font = .systemFont(ofSize: 28)
        iconLabel.textAlignment = .center

        iconLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        // Name Label
        containerView.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = .label

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconContainer.snp.right).offset(16)
            make.top.equalToSuperview().offset(16)
        }

        // Model Label
        containerView.addSubview(modelLabel)
        modelLabel.font = .systemFont(ofSize: 14)
        modelLabel.textColor = .secondaryLabel

        modelLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }

        // Status Label
        containerView.addSubview(statusLabel)
        statusLabel.font = .systemFont(ofSize: 13)
        statusLabel.textColor = .systemGreen

        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(modelLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(-16)
        }

        // Battery Icon
        containerView.addSubview(batteryIcon)
        batteryIcon.font = .systemFont(ofSize: 14)
        batteryIcon.text = "🔋"

        batteryIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-48)
            make.centerY.equalToSuperview()
        }

        // Battery Label
        containerView.addSubview(batteryLabel)
        batteryLabel.font = .systemFont(ofSize: 14, weight: .medium)
        batteryLabel.textColor = .label

        batteryLabel.snp.makeConstraints { make in
            make.left.equalTo(batteryIcon.snp.right).offset(4)
            make.centerY.equalTo(batteryIcon)
        }

        // Chevron
        containerView.addSubview(chevronIcon)
        chevronIcon.text = "›"
        chevronIcon.font = .systemFont(ofSize: 20, weight: .semibold)
        chevronIcon.textColor = .tertiaryLabel

        chevronIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }

    func configure(with device: Device) {
        iconLabel.text = device.icon
        iconContainer.backgroundColor = device.color.withAlphaComponent(0.15)
        nameLabel.text = device.name
        modelLabel.text = device.model
        statusLabel.text = device.isConnected ? "Connected" : "Not Connected"
        statusLabel.textColor = device.isConnected ? .systemGreen : .secondaryLabel

        if let battery = device.battery {
            batteryIcon.isHidden = false
            batteryLabel.isHidden = false
            batteryLabel.text = "\(battery)%"
            batteryLabel.textColor = battery > 20 ? .label : .systemRed
        } else {
            batteryIcon.isHidden = true
            batteryLabel.isHidden = true
        }
    }
}

// MARK: - Main View Controller
class ViewController: UIViewController {

    private let tableView = UITableView()
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let devices: [Device] = [
        Device(name: "iPhone 15 Pro", model: "John's iPhone", systemName: "iOS 17.5",
               icon: "📱", color: .systemBlue, battery: 87, isConnected: true),
        Device(name: "MacBook Pro", model: "14-inch, 2023", systemName: "macOS Sonoma",
               icon: "💻", color: .systemGray, battery: nil, isConnected: true),
        Device(name: "iPad Air", model: "iPad (5th generation)", systemName: "iPadOS 17.5",
               icon: "📲", color: .systemPurple, battery: 45, isConnected: true),
        Device(name: "Apple Watch", model: "Series 9", systemName: "watchOS 10.5",
               icon: "⌚️", color: .systemRed, battery: 62, isConnected: true),
        Device(name: "AirPods Pro", model: "2nd generation", systemName: "",
               icon: "🎧", color: .systemIndigo, battery: 93, isConnected: false),
        Device(name: "Apple TV", model: "Apple TV 4K", systemName: "tvOS 17",
               icon: "📺", color: .systemTeal, battery: nil, isConnected: true),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        // Header
        view.addSubview(headerView)
        headerView.backgroundColor = .systemGroupedBackground

        headerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }

        headerView.addSubview(titleLabel)
        titleLabel.text = "My Devices"
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .label

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
        }

        headerView.addSubview(subtitleLabel)
        subtitleLabel.text = "\(devices.filter { $0.isConnected }.count) devices connected"
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textColor = .secondaryLabel

        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }

        // Table View
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(DeviceCell.self, forCellReuseIdentifier: DeviceCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Table View Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier, for: indexPath) as! DeviceCell
        cell.configure(with: devices[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        let alert = UIAlertController(title: device.name, message: device.model, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
