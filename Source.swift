//
//  Source.swift
//  MaGiamGia
//
//  Created by ScofieldNguyen on 8/3/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class Source: NSObject {
    var sourceName: String?
    var sourceImageName: String?
    init(sourceName: String, sourceImageName: String) {
        super.init()
        self.sourceName = sourceName
        self.sourceImageName = sourceImageName
    }
}
