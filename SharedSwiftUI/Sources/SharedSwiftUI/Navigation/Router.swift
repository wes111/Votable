//
//  Router.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Foundation
import SwiftUI

@MainActor
public protocol RouterProtocol {
    var navigationPath: NavigationPath { get }
    
    func push<Path: Hashable>(_ path: Path)
    func push<Path: Hashable>(_ paths: [Path])
    func pop()
    func pop(count: Int)
    func popToRoot()
}

@MainActor @Observable
public final class Router: RouterProtocol {
    
    public var navigationPath = NavigationPath()
    
    public init() {}
    
    public func push<Path: Hashable>(_ path: Path) {
        navigationPath.append(path)
    }
    
    public func push<Path: Hashable>(_ paths: [Path]) {
        paths.forEach { navigationPath.append($0) }
    }
    
    public func pop() {
        navigationPath.removeLast()
    }
    
    public func pop(count: Int) {
        for _ in 0..<count {
            navigationPath.removeLast()
        }
    }
    
    public func popToRoot() {
        for _ in 0 ..< navigationPath.count {
            navigationPath.removeLast()
        }
    }
    
}
