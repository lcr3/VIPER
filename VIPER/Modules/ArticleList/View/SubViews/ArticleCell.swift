//
//  ArticleCell.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell, NibRegistrable  {

    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var likeCoutLabel: UILabel!

    func setArticle(_ article: Article) {
        articleTitleLabel.text = article.title
//        likeCoutLabel.text = String(article.likesCount)
    }
}

protocol Registrable where Self: UIView {
    static var reuseIdentifier: String { get }
}

extension Registrable {
    static var reuseIdentifier: String {
        return self.className
    }
}

protocol ClassRegistrable: Registrable { }

protocol NibRegistrable: Registrable {
    static var nib: UINib { get }
}

extension NibRegistrable {
    static var nib: UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
