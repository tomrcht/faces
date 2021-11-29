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
    private var isZoomedIn = false
    /// Offset around the image view to allow scrolling in the entire image
    /// This prevents the issue where you can not go at the very top or bottom of the image
    private let allowedOffset: CGFloat = 100

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

        let imageHeight = imageView.image?.size.height ?? 0
        let imageWidth = imageView.image?.size.width ?? 0
        let newImageHeight = (imageHeight / imageWidth) * UIScreen.main.bounds.width

        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()

            make.height.equalTo(newImageHeight + allowedOffset)
        }

        #if DEBUG
        backgroundColor = .black
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
        isZoomedIn.toggle()
    }
}

extension ZoomableImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
