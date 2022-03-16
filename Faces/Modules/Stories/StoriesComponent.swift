//
//  StoriesComponent.swift
//  Faces
//
//  Created by Tom Rochat on 14/03/2022.
//

import Foundation
import NeedleFoundation
import UIKit

protocol StoriesBuilder {
    var storiesViewController: UIViewController { get }
}

final class StoriesComponent: Component<EmptyDependency>, StoriesBuilder {
    var storiesViewController: UIViewController {
        StoriesViewController(viewModel: storiesViewModel)
    }

    private var storiesViewModel: StoriesViewModel {
        StoriesViewModel()
    }
}
