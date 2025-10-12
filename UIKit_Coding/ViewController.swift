//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI

// MARK: - Tree Node Model
class TreeNode {
    let id: String
    let title: String
    let subtitle: String?
    let icon: String
    var children: [TreeNode]
    var isExpanded: Bool = false
    weak var parent: TreeNode?

    init(id: String, title: String, subtitle: String? = nil, icon: String, children: [TreeNode] = []) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.children = children
        self.children.forEach { $0.parent = self }
    }

    var level: Int {
        var count = 0
        var current = parent
        while current != nil {
            count += 1
            current = current?.parent
        }
        return count
    }
}

// MARK: - Tree Cell
class TreeCell: UITableViewCell {
    private let containerView = UIView()
    private let iconLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let indentView = UIView()

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

        contentView.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray5.cgColor

        containerView.addSubview(indentView)
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(chevronImageView)

        iconLabel.font = .systemFont(ofSize: 24)
        iconLabel.textAlignment = .center

        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label

        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 1

        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .systemGray

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-4)
        }

        indentView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(0)
        }

        iconLabel.snp.makeConstraints { make in
            make.leading.equalTo(indentView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconLabel.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }

        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }

    func configure(with node: TreeNode, hasChildren: Bool) {
        iconLabel.text = node.icon
        titleLabel.text = node.title
        subtitleLabel.text = node.subtitle
        subtitleLabel.isHidden = node.subtitle == nil

        let indentWidth = CGFloat(node.level) * 24
        indentView.snp.updateConstraints { make in
            make.width.equalTo(indentWidth)
        }

        if hasChildren {
            let chevronName = node.isExpanded ? "chevron.down.circle.fill" : "chevron.right.circle.fill"
            chevronImageView.image = UIImage(systemName: chevronName)
            chevronImageView.isHidden = false
        } else {
            chevronImageView.isHidden = true
        }

        // Update constraints for subtitle
        if node.subtitle == nil {
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(iconLabel.snp.trailing).offset(12)
                make.centerY.equalToSuperview()
                make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
            }
        } else {
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(iconLabel.snp.trailing).offset(12)
                make.top.equalToSuperview().offset(12)
                make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
            }
        }
    }
}

// MARK: - Tree View Controller
class ViewController: UIViewController {
    private let tableView = UITableView()
    private var rootNodes: [TreeNode] = []
    private var flattenedNodes: [TreeNode] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDummyData()
        refreshFlattenedNodes()
    }

    private func setupUI() {
        title = "Tree Structure"
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TreeCell.self, forCellReuseIdentifier: "TreeCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupDummyData() {
        // Create sample hierarchical data
        let project1 = TreeNode(
            id: "1",
            title: "Mobile App Project",
            subtitle: "iOS & Android Development",
            icon: "📱",
            children: [
                TreeNode(
                    id: "1.1",
                    title: "Frontend",
                    subtitle: "User Interface Layer",
                    icon: "🎨",
                    children: [
                        TreeNode(id: "1.1.1", title: "Home Screen", subtitle: "Main dashboard", icon: "🏠"),
                        TreeNode(id: "1.1.2", title: "Profile Screen", subtitle: "User profile", icon: "👤"),
                        TreeNode(id: "1.1.3", title: "Settings Screen", subtitle: "App configuration", icon: "⚙️")
                    ]
                ),
                TreeNode(
                    id: "1.2",
                    title: "Backend",
                    subtitle: "Server & API",
                    icon: "🔧",
                    children: [
                        TreeNode(id: "1.2.1", title: "Authentication", subtitle: "Login & signup", icon: "🔐"),
                        TreeNode(id: "1.2.2", title: "Database", subtitle: "Data storage", icon: "💾")
                    ]
                )
            ]
        )

        let project2 = TreeNode(
            id: "2",
            title: "Web Platform",
            subtitle: "E-commerce Website",
            icon: "🌐",
            children: [
                TreeNode(id: "2.1", title: "Product Catalog", subtitle: "Browse products", icon: "📦"),
                TreeNode(id: "2.2", title: "Shopping Cart", subtitle: "Cart management", icon: "🛒"),
                TreeNode(
                    id: "2.3",
                    title: "Payment System",
                    subtitle: "Checkout process",
                    icon: "💳",
                    children: [
                        TreeNode(id: "2.3.1", title: "Payment Gateway", icon: "💰"),
                        TreeNode(id: "2.3.2", title: "Order Confirmation", icon: "✅")
                    ]
                )
            ]
        )

        let project3 = TreeNode(
            id: "3",
            title: "Analytics Dashboard",
            subtitle: "Business Intelligence",
            icon: "📊",
            children: [
                TreeNode(id: "3.1", title: "User Metrics", subtitle: "User engagement stats", icon: "👥"),
                TreeNode(id: "3.2", title: "Revenue Reports", subtitle: "Financial overview", icon: "💵"),
                TreeNode(id: "3.3", title: "Performance", subtitle: "System health", icon: "⚡")
            ]
        )

        rootNodes = [project1, project2, project3]
    }

    private func refreshFlattenedNodes() {
        flattenedNodes = []
        for root in rootNodes {
            flattenNodes(root)
        }
        tableView.reloadData()
    }

    private func flattenNodes(_ node: TreeNode) {
        flattenedNodes.append(node)
        if node.isExpanded {
            for child in node.children {
                flattenNodes(child)
            }
        }
    }

    private func toggleNode(_ node: TreeNode) {
        node.isExpanded.toggle()
        refreshFlattenedNodes()
    }
}

// MARK: - TableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flattenedNodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreeCell", for: indexPath) as! TreeCell
        let node = flattenedNodes[indexPath.row]
        cell.configure(with: node, hasChildren: !node.children.isEmpty)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = flattenedNodes[indexPath.row]
        if !node.children.isEmpty {
            toggleNode(node)
        }
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
