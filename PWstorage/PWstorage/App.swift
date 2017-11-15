//
//  App.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-10-30.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import Foundation
import RealmSwift

struct App {
     var title : String
}

class AppRealm: Object {
    @objc dynamic var title = ""
}
