//
//  RealmService.swift
//  weather_realm+decodable
//
//  Created by Artem Grebinik on 10/15/18.
//  Copyright © 2018 Artem Hrebinik. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch  {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String:Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch  {
            print(error)
        }
    }
    
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch  {
            print(error)
        }
    }
}
