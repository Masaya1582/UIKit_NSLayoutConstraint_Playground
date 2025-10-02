//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SwiftUI

struct DummyItem {
    let id = UUID()
    let title: String
    let subTitle: String
}

final class ViewController: UIViewController {

    private let dummyItems: [DummyItem] = [
        DummyItem(title: "Big Title 1", subTitle: "Subtitle for item 1"),
        DummyItem(title: "Big Title 2", subTitle: "Subtitle for item 2"),
        DummyItem(title: "Big Title 3", subTitle: "Subtitle for item 3"),
        DummyItem(title: "Big Title 4", subTitle: "Subtitle for item 4"),
        DummyItem(title: "Big Title 5", subTitle: "Subtitle for item 5"),
        DummyItem(title: "Big Title 6", subTitle: "Subtitle for item 6"),
        DummyItem(title: "Big Title 7", subTitle: "Subtitle for item 7"),
        DummyItem(title: "Big Title 8", subTitle: "Subtitle for item 8"),
        DummyItem(title: "Big Title 9", subTitle: "Subtitle for item 9"),
        DummyItem(title: "Big Title 10", subTitle: "Subtitle for item 10")
    ]

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        setupTableView()
    }

    private func configureUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DummyTableViewCell.self, forCellReuseIdentifier: DummyTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DummyTableViewCell.identifier, for: indexPath) as? DummyTableViewCell else {
            return UITableViewCell()
        }
        let item = dummyItems[indexPath.row]
        cell.configure(title: item.title, subTitle: item.subTitle)
        return cell
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
