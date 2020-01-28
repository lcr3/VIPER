//
//  SearchResponse.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

struct SearchResponse<Item: Decodable>: Decodable {
    let articles: [Article]
}
