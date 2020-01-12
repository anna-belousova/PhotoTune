//
//  EditedImagesPresenter.swift
//  PhotoTune
//
//  Created by MacBook Air on 08.01.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import UIKit

protocol IEditedImagesPresenter
{
	func getImages() -> [EditedImage]
	func loadImages()
	func getPreviewFor(editedImage: EditedImage) -> UIImage?
	func transferImageForEditing(image: UIImage?, editedImage: EditedImage?)
}

final class EditedImagesPresenter
{
	private let repository: IRepository
	private let router: IEditedImagesRouter
	weak var viewController: IEditedImagesCollectionViewController?
	private var images = [EditedImage]()

	init(repository: IRepository, router: IEditedImagesRouter) {
		self.repository = repository
		self.router = router
	}
}

extension EditedImagesPresenter: IEditedImagesPresenter
{
	func transferImageForEditing(image: UIImage?, editedImage: EditedImage?) {
		router.goToEditingScreen(image: image, editedImage: editedImage)
	}

	func loadImages() {
		images = repository.getEditedImages()
		print(images.count)
		self.viewController?.updateCollectionView()
	}

	func getImages() -> [EditedImage] { images }

	func getPreviewFor(editedImage: EditedImage) -> UIImage? {
		repository.loadPreviewFor(editedImage: editedImage)
	}
}
