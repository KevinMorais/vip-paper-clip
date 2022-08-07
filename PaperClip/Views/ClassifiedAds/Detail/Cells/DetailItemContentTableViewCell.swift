//
//  DetailItemContentTableViewCell.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//

import UIKit
import PaperClipDesignKit

final class DetailItemContentTableViewCell: UITableViewCell {

    private lazy var contentLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLabel)
        contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ viewModel: DetailItemViewModel.ContentCell) {
        contentLabel.text = viewModel.description
    }

}
