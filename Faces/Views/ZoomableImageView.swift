//
//  ZoomableImageView.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import UIKit
import SnapKit

final class ZoomableImageView: UIScrollView {
    // MARK: - Properties
    /// Track wether the user did double tap to zoom in
    private var isZoomedIn: Bool {
        zoomScale > 1
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Lifecycle
    init(image: UIImage) {
        super.init(frame: .zero)
        setup(with: image)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    private func setup(with image: UIImage) {
        // ScrollView setup
        minimumZoomScale = 1
        maximumZoomScale = 4
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap))
        doubleTapGesture.numberOfTouchesRequired = 1
        doubleTapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGesture)

        // ImageView setup
        imageView.image = image
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }

        #if DEBUG
        backgroundColor = .systemGreen
        imageView.backgroundColor = .systemYellow
        #endif
    }

    // MARK: - Gestures
    @objc
    private func onDoubleTap(_ sender: UITapGestureRecognizer) {
        if isZoomedIn {
            setZoomScale(1.0, animated: true)
        } else {
            let location = sender.location(in: imageView)
            let zoomLocation = CGRect(origin: location, size: .zero)
            zoom(to: zoomLocation, animated: true)
        }
    }
}

extension ZoomableImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard zoomScale > 1 else {
            scrollView.contentInset = .zero
            return
        }

        guard let image = imageView.image else { return }

        let widthRatio = imageView.frame.width / image.size.width
        let heightRatio = imageView.frame.height / image.size.height
        let sizeRatio = min(widthRatio, heightRatio)

        let newImageWidth = image.size.width * sizeRatio
        let newImageHeight = image.size.height * sizeRatio

        let horizontalInset: CGFloat
        if newImageWidth * zoomScale > imageView.frame.width {
            horizontalInset = (newImageWidth - imageView.frame.width) / 2
        } else {
            horizontalInset = (frame.width - contentSize.width) / 2
        }

        let verticalInset: CGFloat
        if newImageHeight * zoomScale > imageView.frame.height {
            verticalInset = (newImageHeight - imageView.frame.height) / 2
        } else {
            verticalInset = (frame.height - contentSize.height) / 2
        }

        contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset)
    }
}
