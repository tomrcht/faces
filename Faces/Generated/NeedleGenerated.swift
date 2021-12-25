

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent->AsyncComponent") { component in
        return AsyncDependenciesfe393ca55edb2c04ec34Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent->KeyframeComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent->CustomSheetComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent->ThemeComponent") { component in
        return ThemeDependencies140bd1199cd34fc9bb89Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent->ZoomComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->HomeComponent->CoreAnimationComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

private class AsyncDependenciesfe393ca55edb2c04ec34BaseProvider: AsyncDependencies {
    var kanyeService: KanyeService {
        return rootComponent.kanyeService
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->HomeComponent->AsyncComponent
private class AsyncDependenciesfe393ca55edb2c04ec34Provider: AsyncDependenciesfe393ca55edb2c04ec34BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent.parent as! RootComponent)
    }
}
private class ThemeDependencies140bd1199cd34fc9bb89BaseProvider: ThemeDependencies {
    var themeManager: ThemeManager {
        return rootComponent.themeManager
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->HomeComponent->ThemeComponent
private class ThemeDependencies140bd1199cd34fc9bb89Provider: ThemeDependencies140bd1199cd34fc9bb89BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent.parent as! RootComponent)
    }
}
