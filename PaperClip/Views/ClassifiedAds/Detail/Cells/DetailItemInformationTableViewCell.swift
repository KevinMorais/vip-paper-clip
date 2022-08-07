//
//  DetailItemInformationTableViewCell.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//

import UIKit
import PaperClipDesignKit

final class DetailItemInformationTableViewCell: UITableViewCell {

    private lazy var titleLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()

    private lazy var subtitleLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ viewModel: DetailItemViewModel.InformationCell) {
        titleLabel.text = viewModel.infoTitle
        subtitleLabel.text = viewModel.infoSubtitle
    }

}
