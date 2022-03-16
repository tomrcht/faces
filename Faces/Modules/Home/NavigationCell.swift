//
//  NavigationCell.swift
//  Faces
//
//  Created by Tom Rochat on 03/11/2021.
//

import UIKit
import SnapKit

final class NavigationCell: UITableViewCell {
    static let reuseIdentifier = "cell-navigation"

    // MARK: - UI
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var navigationIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .darkGray
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "?"
        return label
    }()

    // MARK: - Cell lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }

        contentView.addSubview(navigationIcon)
        navigationIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    func update(with data: NavigationCell.Data) {
        titleLabel.text = data.title
        iconView.image = UIImage(systemName: data.iconName)
        iconView.tintColor = .systemPurple
    }
}

extension NavigationCell {
    struct Data {
        let title: String
        let iconName: String
        let tag: NavigationTag
    }

    enum NavigationTag {
        case zoom
        case `async`
        case keyframe
        case coreAnimation
        case customSheet
        case connectivity
        case alertWindow
        case stories
    }
}
