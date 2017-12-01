//
//  App.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-10-30.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import Foundation
import RealmSwift

class AppRealm: Object {
    // 'id' = 'Primary Keys'. Realm needs 'Primary Keys' for rewrite data.
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var password = ""
    @objc dynamic var imageData:NSData? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

