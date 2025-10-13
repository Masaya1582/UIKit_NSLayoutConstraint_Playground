//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI

// MARK: - Models
enum OrderStatus: String {
    case delivered = "Delivered"
    case shipped = "Shipped"
    case processing = "Processing"
    case cancelled = "Cancelled"

    var color: UIColor {
        switch self {
        case .delivered: return .systemGreen
        case .shipped: return .systemBlue
        case .processing: return .systemOrange
        case .cancelled: return .systemRed
        }
    }

    var icon: String {
        switch self {
        case .delivered: return "checkmark.circle.fill"
        case .shipped: return "shippingbox.fill"
        case .processing: return "clock.fill"
        case .cancelled: return "xmark.circle.fill"
        }
    }
}

struct OrderItem {
    let name: String
    let quantity: Int
    let price: Double
    let imageEmoji: String
}

struct Order {
    let id: String
    let orderNumber: String
    let date: Date
    let status: OrderStatus
    let items: [OrderItem]
    let subtotal: Double
    let shipping: Double
    let tax: Double

    var total: Double {
        return subtotal + shipping + tax
    }

    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}

// MARK: - Order Cell
class OrderCell: UITableViewCell {
    private let cardView = UIView()
    private let headerView = UIView()
    private let orderNumberLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusBadge = UIView()
    private let statusIconView = UIImageView()
    private let statusLabel = UILabel()

    private let itemsStackView = UIStackView()
    private let dividerView = UIView()

    private let summaryStackView = UIStackView()
    private let itemCountLabel = UILabel()
    private let totalLabel = UILabel()

    private let actionButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(cardView)
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.08
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8

        // Header
        cardView.addSubview(headerView)
        headerView.backgroundColor = .systemGray6
        headerView.layer.cornerRadius = 16
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        headerView.addSubview(orderNumberLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(statusBadge)

        orderNumberLabel.font = .systemFont(ofSize: 16, weight: .bold)
        orderNumberLabel.textColor = .label

        dateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = .secondaryLabel

        statusBadge.layer.cornerRadius = 12
        statusBadge.addSubview(statusIconView)
        statusBadge.addSubview(statusLabel)

        statusIconView.contentMode = .scaleAspectFit
        statusIconView.tintColor = .white

        statusLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        statusLabel.textColor = .white

        // Items
        cardView.addSubview(itemsStackView)
        itemsStackView.axis = .vertical
        itemsStackView.spacing = 8
        itemsStackView.distribution = .fill

        // Divider
        cardView.addSubview(dividerView)
        dividerView.backgroundColor = .systemGray5

        // Summary
        cardView.addSubview(summaryStackView)
        summaryStackView.axis = .horizontal
        summaryStackView.distribution = .equalSpacing

        itemCountLabel.font = .systemFont(ofSize: 14, weight: .medium)
        itemCountLabel.textColor = .secondaryLabel

        totalLabel.font = .systemFont(ofSize: 18, weight: .bold)
        totalLabel.textColor = .label

        summaryStackView.addArrangedSubview(itemCountLabel)
        summaryStackView.addArrangedSubview(totalLabel)

        // Action Button
        cardView.addSubview(actionButton)
        actionButton.setTitle("View Details", for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        actionButton.backgroundColor = .systemBlue
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 10

        setupConstraints()
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }

        orderNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualTo(statusBadge.snp.leading).offset(-8)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(orderNumberLabel.snp.bottom).offset(4)
            make.leading.equalTo(orderNumberLabel)
        }

        statusBadge.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
        }

        statusIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusIconView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }

        itemsStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        dividerView.snp.makeConstraints { make in
            make.top.equalTo(itemsStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }

        summaryStackView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        actionButton.snp.makeConstraints { make in
            make.top.equalTo(summaryStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }

    func configure(with order: Order) {
        orderNumberLabel.text = "Order #\(order.orderNumber)"

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        dateLabel.text = formatter.string(from: order.date)

        statusBadge.backgroundColor = order.status.color
        statusIconView.image = UIImage(systemName: order.status.icon)
        statusLabel.text = order.status.rawValue

        // Clear existing items
        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add item views (show max 3 items)
        let itemsToShow = Array(order.items.prefix(3))
        for item in itemsToShow {
            let itemView = createItemView(for: item)
            itemsStackView.addArrangedSubview(itemView)
        }

        // Add "more items" if needed
        if order.items.count > 3 {
            let moreLabel = UILabel()
            moreLabel.text = "+ \(order.items.count - 3) more item(s)"
            moreLabel.font = .systemFont(ofSize: 13, weight: .medium)
            moreLabel.textColor = .systemBlue
            itemsStackView.addArrangedSubview(moreLabel)
        }

        itemCountLabel.text = "\(order.itemCount) item\(order.itemCount > 1 ? "s" : "")"
        totalLabel.text = String(format: "$%.2f", order.total)
    }

    private func createItemView(for item: OrderItem) -> UIView {
        let container = UIView()

        let emojiLabel = UILabel()
        emojiLabel.text = item.imageEmoji
        emojiLabel.font = .systemFont(ofSize: 28)

        let nameLabel = UILabel()
        nameLabel.text = item.name
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .label

        let detailLabel = UILabel()
        detailLabel.text = "Qty: \(item.quantity)"
        detailLabel.font = .systemFont(ofSize: 12, weight: .regular)
        detailLabel.textColor = .secondaryLabel

        let priceLabel = UILabel()
        priceLabel.text = String(format: "$%.2f", item.price * Double(item.quantity))
        priceLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        priceLabel.textColor = .label

        container.addSubview(emojiLabel)
        container.addSubview(nameLabel)
        container.addSubview(detailLabel)
        container.addSubview(priceLabel)

        emojiLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(emojiLabel.snp.trailing).offset(12)
            make.top.equalToSuperview()
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-8)
        }

        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview()
        }

        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        return container
    }
}

// MARK: - Purchase History View Controller
class ViewController: UIViewController {
    private let tableView = UITableView()
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var orders: [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDummyData()
    }

    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        // Header
        view.addSubview(headerView)
        headerView.backgroundColor = .systemBackground

        headerView.addSubview(titleLabel)
        headerView.addSubview(subtitleLabel)

        titleLabel.text = "Purchase History"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label

        subtitleLabel.text = "Your recent orders"
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel

        // Table View
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupDummyData() {
        let calendar = Calendar.current

        orders = [
            Order(
                id: "1",
                orderNumber: "ORD-2024-1001",
                date: calendar.date(byAdding: .day, value: -2, to: Date())!,
                status: .delivered,
                items: [
                    OrderItem(name: "Wireless Headphones", quantity: 1, price: 149.99, imageEmoji: "🎧"),
                    OrderItem(name: "Phone Case", quantity: 2, price: 24.99, imageEmoji: "📱"),
                    OrderItem(name: "USB-C Cable", quantity: 1, price: 19.99, imageEmoji: "🔌")
                ],
                subtotal: 219.96,
                shipping: 5.99,
                tax: 18.80
            ),
            Order(
                id: "2",
                orderNumber: "ORD-2024-1002",
                date: calendar.date(byAdding: .day, value: -5, to: Date())!,
                status: .shipped,
                items: [
                    OrderItem(name: "Laptop Stand", quantity: 1, price: 79.99, imageEmoji: "💻"),
                    OrderItem(name: "Wireless Mouse", quantity: 1, price: 49.99, imageEmoji: "🖱️")
                ],
                subtotal: 129.98,
                shipping: 7.99,
                tax: 11.44
            ),
            Order(
                id: "3",
                orderNumber: "ORD-2024-1003",
                date: calendar.date(byAdding: .day, value: -7, to: Date())!,
                status: .processing,
                items: [
                    OrderItem(name: "Smart Watch", quantity: 1, price: 299.99, imageEmoji: "⌚"),
                    OrderItem(name: "Watch Band", quantity: 2, price: 39.99, imageEmoji: "⌚"),
                    OrderItem(name: "Screen Protector", quantity: 1, price: 14.99, imageEmoji: "🛡️")
                ],
                subtotal: 394.96,
                shipping: 0.00,
                tax: 32.83
            ),
            Order(
                id: "4",
                orderNumber: "ORD-2024-1004",
                date: calendar.date(byAdding: .day, value: -15, to: Date())!,
                status: .delivered,
                items: [
                    OrderItem(name: "Bluetooth Speaker", quantity: 1, price: 89.99, imageEmoji: "🔊"),
                    OrderItem(name: "Power Bank", quantity: 1, price: 59.99, imageEmoji: "🔋"),
                    OrderItem(name: "Travel Adapter", quantity: 1, price: 29.99, imageEmoji: "🔌"),
                    OrderItem(name: "Cable Organizer", quantity: 3, price: 12.99, imageEmoji: "📦")
                ],
                subtotal: 218.94,
                shipping: 5.99,
                tax: 18.74
            ),
            Order(
                id: "5",
                orderNumber: "ORD-2024-1005",
                date: calendar.date(byAdding: .day, value: -30, to: Date())!,
                status: .cancelled,
                items: [
                    OrderItem(name: "Gaming Keyboard", quantity: 1, price: 129.99, imageEmoji: "⌨️")
                ],
                subtotal: 129.99,
                shipping: 9.99,
                tax: 11.62
            )
        ]

        tableView.reloadData()
    }
}

// MARK: - TableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.configure(with: orders[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        print("Selected order: \(order.orderNumber)")
        // Navigate to order detail screen
    }
}

// MARK: - Usage Example
// In your SceneDelegate or AppDelegate:
// let purchaseVC = PurchaseHistoryViewController()
// let navController = UINavigationController(rootViewController: purchaseVC)
// window?.rootViewController = navController

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
