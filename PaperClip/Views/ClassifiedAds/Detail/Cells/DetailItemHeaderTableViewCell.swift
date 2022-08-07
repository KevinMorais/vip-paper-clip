//
//  DetailItemHeaderTableViewCell.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//

import UIKit
import PaperClipDesignKit

final class DetailItemHeaderTableViewCell: UITableViewCell {

    private let image: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let priceLabel: MediumLabel = {
        let label = MediumLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image, titleLabel, priceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(verticalStackView)
        image.heightAnchor.constraint(equalToConstant: 240).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ viewModel: DetailItemViewModel.HeaderCell) {
        image.set(url: viewModel.imageURL)
        titleLabel.text = viewModel.titleText
        priceLabel.text = viewModel.priceText
    }

}
