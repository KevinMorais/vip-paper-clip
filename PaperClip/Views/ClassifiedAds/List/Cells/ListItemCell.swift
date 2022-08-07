//
//  ListItemCell.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit
import PaperClipDesignKit
import PaperClipCore

final class ListItemCell: UITableViewCell {

    private let itemTitle: MediumLabel = {
        let label = MediumLabel()
        label.numberOfLines = 0
        return label
    }()

    private let image: ImageView = {
        let imageView = ImageView()
        imageView.backgroundColor = .background100
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let creationDateLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.font = label.font.italic
        label.textAlignment = .left
        return label
    }()

    private let priceLabel: MediumLabel = {
        let label = MediumLabel()
        label.textAlignment = .right
        label.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        return label
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemTitle, bottomStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [creationDateLabel, priceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image, verticalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainStackView)
        image.heightAnchor.constraint(equalToConstant: 120).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ viewModel: ListItemsViewModel.Cell) {
        itemTitle.text = viewModel.title
        image.set(url: viewModel.imageURL)
        creationDateLabel.text = viewModel.creationText
        backgroundColor = viewModel.isImportant ? .primary : .background100
        priceLabel.text = viewModel.priceText
    }

}
