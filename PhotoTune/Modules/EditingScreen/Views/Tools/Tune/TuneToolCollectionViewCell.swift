//
//  TuneToolCollectionViewCell.swift
//  PhotoTune
//
//  Created by Mikhail Medvedev on 18.12.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

final class TuneToolCollectionViewCell: ToolCollectionViewCell
{
	static let identifier = "TuneToolCollectionViewCell"

	private let indicator = UIView()
	private let screenSize = UIScreen.main.bounds.width

	var tuneTool: TuneTool? {
		didSet {
			guard let tuneTool = tuneTool?.values else { return }
			setImage(tuneTool.image)
			setTitle(tuneTool.title)
		}
	}

	var isIndicatorShown = false {
		didSet { indicator.isHidden = isIndicatorShown ? false : true }
	}

	override var isSelected: Bool {
		didSet {
			animateScale(condition: isSelected)
		}
	}

	override var isHighlighted: Bool {
		didSet { animateScale(condition: isHighlighted) }
	}

	override init(frame: CGRect = .zero) {
		super.init(frame: frame)
		initialSetup()
		configureIndicator()
	}

	private func initialSetup() {
		let screenSizeOfiPhoneSe: CGFloat = 320
		if screenSize <= screenSizeOfiPhoneSe  {
			setFont(.systemFont(ofSize: 11, weight: .light))
		}
		else { setFont(.systemFont(ofSize: 14, weight: .light)) }

		setImageViewContentMode(mode: .center)

		if #available(iOS 13.0, *) {
			setTextColor(.label)
			setBorderToImage(color: .label, width: 1)
		}
		else {
			setTextColor(.darkText)
			setBorderToImage(color: .black, width: 1)
		}
	}

	private func configureIndicator() {
		indicator.isHidden = true
		if #available(iOS 13.0, *) {
			indicator.backgroundColor = .label
		}
		else {
			indicator.backgroundColor = .systemGreen
		}
		indicator.layer.cornerRadius = EditingScreenMetrics.tuneToolIndicatorRadius / 2
		addSubview(indicator)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		indicator.anchor(
			top: nil,
			leading: nil,
			bottom: self.bottomAnchor,
			trailing: nil,
			padding: .init(
				top: 0,
				left: 0,
				bottom: self.bounds.height + EditingScreenMetrics.tuneToolIndicatorRadius / 2,
				right: 0),
			size: .init(width: EditingScreenMetrics.tuneToolIndicatorRadius,
						height: EditingScreenMetrics.tuneToolIndicatorRadius)
		)
	}
}
