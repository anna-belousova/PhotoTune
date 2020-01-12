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
	func getPreviewFor(_ editedImage: EditedImage) -> UIImage?
	func deleteImagesFromStorage(_ selectedIndexPaths: [IndexPath])
	func transferImageForEditing(image: UIImage?, editedImage: EditedImage?)
	func transferToSearchScreen()
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

	func inject(viewController: IEditedImagesCollectionViewController) {
		self.viewController = viewController
	}
}

extension EditedImagesPresenter: IEditedImagesPresenter
{
	func transferImageForEditing(image: UIImage?, editedImage: EditedImage?) {
		router.goToEditingScreen(image: image, editedImage: editedImage)
	}

	func transferToSearchScreen() {
		router.goToSearchScreen()
	}

	func loadImages() {
		images = repository.getEditedImages()
		viewController?.updateCollectionView()
	}

	func deleteImagesFromStorage(_ selectedIndexPaths: [IndexPath]) {
		for indexPath in selectedIndexPaths {
			images.remove(at: indexPath.row)
		}
		repository.updateEditedImages(images)
	}

	func getImages() -> [EditedImage] { images }

	func getPreviewFor(_ editedImage: EditedImage) -> UIImage? {
		repository.loadPreviewFor(editedImage: editedImage)
	}
}
