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
struct RecipeStep {
    let title: String
    let description: String
    let duration: Int // in minutes
    let imageName: String
    let tips: String?
}

struct Recipe {
    let title: String
    let totalTime: Int
    let servings: Int
    let difficulty: String
    let steps: [RecipeStep]
}

// MARK: - Recipe Step Cell
class RecipeStepCell: UITableViewCell {
    private let containerView = UIView()
    private let stepNumberLabel = UILabel()
    private let stepImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let durationView = UIView()
    private let clockIcon = UILabel()
    private let durationLabel = UILabel()
    private let tipsView = UIView()
    private let tipsLabel = UILabel()
    private let timelineView = UIView()
    private let timelineDot = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear

        // Timeline
        timelineView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
        contentView.addSubview(timelineView)
        timelineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(3)
            make.top.bottom.equalToSuperview()
        }

        // Timeline Dot
        timelineDot.backgroundColor = .systemBlue
        timelineDot.layer.cornerRadius = 10
        timelineDot.layer.borderWidth = 3
        timelineDot.layer.borderColor = UIColor.systemBackground.cgColor
        contentView.addSubview(timelineDot)
        timelineDot.snp.makeConstraints { make in
            make.centerX.equalTo(timelineView)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }

        // Container
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.08
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.equalTo(timelineView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }

        // Step Number
        stepNumberLabel.font = .systemFont(ofSize: 14, weight: .bold)
        stepNumberLabel.textColor = .white
        stepNumberLabel.backgroundColor = .systemBlue
        stepNumberLabel.textAlignment = .center
        stepNumberLabel.layer.cornerRadius = 16
        stepNumberLabel.clipsToBounds = true
        containerView.addSubview(stepNumberLabel)
        stepNumberLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }

        // Step Image
        stepImageView.contentMode = .scaleAspectFill
        stepImageView.clipsToBounds = true
        stepImageView.layer.cornerRadius = 12
        stepImageView.backgroundColor = .systemGray5
        containerView.addSubview(stepImageView)
        stepImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(stepNumberLabel.snp.bottom).offset(12)
            make.height.equalTo(180)
        }

        // Title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(stepImageView.snp.bottom).offset(16)
        }

        // Description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        // Duration View
        durationView.backgroundColor = .systemOrange.withAlphaComponent(0.1)
        durationView.layer.cornerRadius = 8
        containerView.addSubview(durationView)
        durationView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.height.equalTo(36)
        }

        clockIcon.text = "⏱"
        clockIcon.font = .systemFont(ofSize: 16)
        durationView.addSubview(clockIcon)
        clockIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }

        durationLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        durationLabel.textColor = .systemOrange
        durationView.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.left.equalTo(clockIcon.snp.right).offset(6)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }

        // Tips View
        tipsView.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        tipsView.layer.cornerRadius = 8
        tipsView.isHidden = true
        containerView.addSubview(tipsView)
        tipsView.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(durationView.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-16)
        }

        let tipIcon = UILabel()
        tipIcon.text = "💡"
        tipIcon.font = .systemFont(ofSize: 16)
        tipsView.addSubview(tipIcon)
        tipIcon.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(12)
        }

        tipsLabel.font = .systemFont(ofSize: 14)
        tipsLabel.textColor = .systemGreen
        tipsLabel.numberOfLines = 0
        tipsView.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { make in
            make.left.equalTo(tipIcon.snp.right).offset(8)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    func configure(with step: RecipeStep, stepNumber: Int, isLast: Bool) {
        stepNumberLabel.text = "\(stepNumber)"
        titleLabel.text = step.title
        descriptionLabel.text = step.description
        durationLabel.text = "\(step.duration) min"

        // Simulate image
        stepImageView.backgroundColor = [
            UIColor.systemBlue, .systemPurple, .systemPink,
            .systemOrange, .systemTeal, .systemIndigo
        ].randomElement()?.withAlphaComponent(0.3)

        if let tips = step.tips {
            tipsView.isHidden = false
            tipsLabel.text = tips
        } else {
            tipsView.isHidden = true
            tipsView.snp.remakeConstraints { make in
                make.left.right.equalTo(titleLabel)
                make.top.equalTo(durationView.snp.bottom).offset(12)
                make.height.equalTo(0)
                make.bottom.equalToSuperview().offset(-16)
            }
        }

        // Hide timeline for last item
        if isLast {
            timelineView.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(30)
                make.width.equalTo(3)
                make.top.equalToSuperview()
                make.bottom.equalTo(timelineDot.snp.centerY)
            }
        }
    }
}

// MARK: - Recipe Header View
class RecipeHeaderView: UIView {
    private let titleLabel = UILabel()
    private let statsStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemBackground

        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
        }

        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 12
        addSubview(statsStackView)
        statsStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.title

        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let stats = [
            ("⏱", "\(recipe.totalTime) min", "Total Time"),
            ("🍽", "\(recipe.servings)", "Servings"),
            ("📊", recipe.difficulty, "Difficulty")
        ]

        for stat in stats {
            let statView = createStatView(icon: stat.0, value: stat.1, label: stat.2)
            statsStackView.addArrangedSubview(statView)
        }
    }

    private func createStatView(icon: String, value: String, label: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12

        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 24)
        iconLabel.textAlignment = .center
        view.addSubview(iconLabel)
        iconLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        valueLabel.textAlignment = .center
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconLabel.snp.bottom).offset(4)
        }

        let descLabel = UILabel()
        descLabel.text = label
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = .secondaryLabel
        descLabel.textAlignment = .center
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(valueLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-12)
        }

        return view
    }
}

// MARK: - Recipe Timeline View Controller
class ViewController: UIViewController {
    private let tableView = UITableView()
    private let headerView = RecipeHeaderView()

    private let recipe = Recipe(
        title: "Classic Chocolate Chip Cookies",
        totalTime: 45,
        servings: 24,
        difficulty: "Easy",
        steps: [
            RecipeStep(
                title: "Prepare Ingredients",
                description: "Gather all ingredients and measure them out. Make sure butter is at room temperature for easier mixing.",
                duration: 5,
                imageName: "ingredients",
                tips: "Room temperature ingredients mix better and create a more uniform dough."
            ),
            RecipeStep(
                title: "Mix Dry Ingredients",
                description: "In a medium bowl, whisk together flour, baking soda, and salt until well combined.",
                duration: 3,
                imageName: "dry_mix",
                tips: nil
            ),
            RecipeStep(
                title: "Cream Butter and Sugars",
                description: "In a large bowl, beat butter with both sugars until light and fluffy, about 3-4 minutes.",
                duration: 5,
                imageName: "creaming",
                tips: "Properly creamed butter should look pale and fluffy, not greasy."
            ),
            RecipeStep(
                title: "Add Eggs and Vanilla",
                description: "Beat in eggs one at a time, then mix in vanilla extract until fully incorporated.",
                duration: 2,
                imageName: "eggs",
                tips: nil
            ),
            RecipeStep(
                title: "Combine Wet and Dry",
                description: "Gradually fold in the dry ingredients until just combined. Don't overmix! Fold in chocolate chips.",
                duration: 3,
                imageName: "combining",
                tips: "Overmixing develops gluten and makes cookies tough. Stop as soon as flour disappears."
            ),
            RecipeStep(
                title: "Chill Dough",
                description: "Cover the bowl and refrigerate for at least 30 minutes. This helps prevent spreading.",
                duration: 30,
                imageName: "chilling",
                tips: "Chilling is crucial! It helps cookies maintain their shape and enhances flavor."
            ),
            RecipeStep(
                title: "Bake to Perfection",
                description: "Preheat oven to 350°F. Scoop dough onto lined baking sheets and bake for 10-12 minutes until edges are golden.",
                duration: 12,
                imageName: "baking",
                tips: "Cookies will look slightly underdone in the center - they'll continue cooking on the hot pan!"
            )
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        title = "Recipe"

        headerView.configure(with: recipe)
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeStepCell.self, forCellReuseIdentifier: "StepCell")
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 32, right: 0)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
}

// MARK: - UITableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.steps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! RecipeStepCell
        let step = recipe.steps[indexPath.row]
        let isLast = indexPath.row == recipe.steps.count - 1
        cell.configure(with: step, stepNumber: indexPath.row + 1, isLast: isLast)
        return cell
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
