//
//  UITableViewExtention.swift
//  VIPER
//
//  Created by okano on 2020/01/19.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: Registrable & UITableViewCell>(_ registrableType: T.Type) {
        switch registrableType {
        case let nibRegistrableType as NibRegistrable.Type:
            register(nibRegistrableType.nib, forCellReuseIdentifier: nibRegistrableType.reuseIdentifier)
        case let classRegistrableType as ClassRegistrable.Type:
            register(classRegistrableType, forCellReuseIdentifier: classRegistrableType.reuseIdentifier)
        default:
            assertionFailure("\(registrableType) is unknown type")
        }
    }

    func dequeueReusableCell<T: Registrable & UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }
        return cell
    }
}
