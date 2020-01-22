//
//  Extentions.swift
//  VIPER
//
//  Created by ryookano on 2020/01/14.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit
import Foundation

extension NSObject: ClassNameProtocol {

}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    public static var className: String {
        String(describing: self)
    }

    public var className: String {
        Self.className
    }
}
// StoryBoardからControllerを取得する

public enum StoryboardInstantiateType {
    case initial
    case identifier(String)
}

public protocol StoryboardInstantiatable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var instantiateType: StoryboardInstantiateType { get }
}

public extension StoryboardInstantiatable where Self: NSObject {
    public static var storyboardName: String {
        className
    }

    public static var storyboardBundle: Bundle {
        Bundle(for: self)
    }

    private static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    }

    public static var instantiateType: StoryboardInstantiateType {
        .identifier(className)
    }
}

public extension StoryboardInstantiatable where Self: UIViewController {
    public static func instantiate() -> Self {
        switch instantiateType {
        case .initial:
            // swiftlint:disable:next force_cast
            return storyboard.instantiateInitialViewController() as! Self
        case .identifier(let identifier):
            // swiftlint:disable:next force_cast
            return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        }
    }
}

