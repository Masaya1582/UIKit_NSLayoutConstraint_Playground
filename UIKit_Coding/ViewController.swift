//
//  ViewController.swift
//  UIKit_Coding
//
//  Created by Cookie-san on 2025/10/02.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.86, alpha: 1.0)
        return view
    }()

    private let headerIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "cross.case.fill")
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Dental Appointment"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let headerSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Schedule your visit"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        return label
    }()

    private let formStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        return stack
    }()

    // Form fields
    private let nameTextField = CustomTextField(placeholder: "Full Name", icon: "person.fill")
    private let emailTextField = CustomTextField(placeholder: "Email Address", icon: "envelope.fill")
    private let phoneTextField = CustomTextField(placeholder: "Phone Number", icon: "phone.fill")

    private let dateLabel = SectionLabel(text: "Preferred Date")
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.minimumDate = Date()
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 12
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor.systemGray4.cgColor
        return picker
    }()

    private let timeLabel = SectionLabel(text: "Preferred Time")
    private let timeSegmentedControl: UISegmentedControl = {
        let items = ["Morning", "Afternoon", "Evening"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.backgroundColor = .white
        control.layer.cornerRadius = 12
        control.layer.borderWidth = 1
        control.layer.borderColor = UIColor.systemGray4.cgColor
        return control
    }()

    private let serviceLabel = SectionLabel(text: "Service Type")
    private let serviceButtons: [ServiceButton] = [
        ServiceButton(title: "Check-up", icon: "stethoscope"),
        ServiceButton(title: "Cleaning", icon: "sparkles"),
        ServiceButton(title: "Filling", icon: "bandage.fill"),
        ServiceButton(title: "Extraction", icon: "cross.fill"),
        ServiceButton(title: "Whitening", icon: "moon.stars.fill"),
        ServiceButton(title: "Other", icon: "ellipsis.circle.fill")
    ]

    private let notesLabel = SectionLabel(text: "Additional Notes (Optional)")
    private let notesTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.layer.cornerRadius = 12
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemGray4.cgColor
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        tv.backgroundColor = .white
        return tv
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Book Appointment", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.86, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        return button
    }()

    private var selectedServiceButton: ServiceButton?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemGroupedBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(headerView)
        headerView.addSubview(headerIcon)
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerSubtitle)

        contentView.addSubview(formStackView)

        // Setup constraints
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }

        headerIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(48)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(headerIcon.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }

        headerSubtitle.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }

        formStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-24)
        }

        // Add form elements to stack
        formStackView.addArrangedSubview(nameTextField)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(phoneTextField)

        formStackView.addArrangedSubview(dateLabel)
        formStackView.addArrangedSubview(datePicker)

        formStackView.addArrangedSubview(timeLabel)
        formStackView.addArrangedSubview(timeSegmentedControl)

        formStackView.addArrangedSubview(serviceLabel)

        let serviceGrid = createServiceGrid()
        formStackView.addArrangedSubview(serviceGrid)

        formStackView.addArrangedSubview(notesLabel)
        formStackView.addArrangedSubview(notesTextView)

        formStackView.addArrangedSubview(submitButton)

        // Set heights
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        datePicker.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        timeSegmentedControl.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        notesTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

        submitButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
    }

    private func createServiceGrid() -> UIView {
        let containerView = UIView()

        let topStack = UIStackView(arrangedSubviews: Array(serviceButtons[0...2]))
        topStack.axis = .horizontal
        topStack.spacing = 12
        topStack.distribution = .fillEqually

        let bottomStack = UIStackView(arrangedSubviews: Array(serviceButtons[3...5]))
        bottomStack.axis = .horizontal
        bottomStack.spacing = 12
        bottomStack.distribution = .fillEqually

        let mainStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 12

        containerView.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        serviceButtons.forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(80)
            }
        }

        return containerView
    }

    private func setupActions() {
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)

        serviceButtons.forEach { button in
            button.addTarget(self, action: #selector(serviceTapped(_:)), for: .touchUpInside)
        }
    }

    @objc private func serviceTapped(_ sender: ServiceButton) {
        selectedServiceButton?.isSelected = false
        sender.isSelected = true
        selectedServiceButton = sender
    }

    @objc private func submitTapped() {
        let alert = UIAlertController(
            title: "Success!",
            message: "Your appointment has been scheduled. We'll send you a confirmation email shortly.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Custom Components

class CustomTextField: UITextField {
    private let iconView = UIImageView()

    init(placeholder: String, icon: String) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: 16)
        self.borderStyle = .none
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor

        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = .systemGray
        iconView.contentMode = .scaleAspectFit

        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        iconView.frame = CGRect(x: 12, y: 5, width: 20, height: 20)
        iconContainer.addSubview(iconView)

        leftView = iconContainer
        leftViewMode = .always

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 30))
        rightView = paddingView
        rightViewMode = .always
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SectionLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.textColor = .darkGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ServiceButton: UIButton {
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    init(title: String, icon: String) {
        super.init(frame: .zero)

        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor

        let iconImage = UIImageView()
        iconImage.image = UIImage(systemName: icon)
        iconImage.tintColor = .systemGray
        iconImage.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center

        addSubview(iconImage)
        addSubview(label)

        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(28)
        }

        label.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(4)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateAppearance() {
        if isSelected {
            backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.86, alpha: 0.1)
            layer.borderColor = UIColor(red: 0.2, green: 0.6, blue: 0.86, alpha: 1.0).cgColor
        } else {
            backgroundColor = .white
            layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SwiftUIViewController()
    }
}
