//
//  Model.swift
//  alamofireTest
//
//  Created by Artem Grebinik on 21.04.2018.
//  Copyright © 2018 Artem Hrebinik. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Wel:Object, Decodable {
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var timezone: String = ""
   
    @objc dynamic var currently: Cur?
    @objc dynamic var daily: Day?
    @objc dynamic var hourly: Hour?

    private enum TopCodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currently
        case minutely
        case hourly
        case daily
        case flags
        case offset
    }
    
    convenience init(latitude: Double, longitude: Double, timezone: String, currently:Cur, daily:Day, hourly:Hour) {
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
        self.timezone = timezone
        self.currently = currently
        self.daily = daily
        self.hourly = hourly
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: TopCodingKeys.self)
        
        let lat = try container.decode(Double.self, forKey: .latitude)
        let lng = try container.decode(Double.self, forKey: .longitude)
        let zone = try container.decode(String.self, forKey: .timezone)

        let c = try container.decode(Cur.self, forKey: .currently)
        let d = try container.decode(Day.self, forKey: .daily)
        let h = try container.decode(Hour.self, forKey: .hourly)
        
        self.init(latitude: lat, longitude: lng, timezone: zone, currently: c, daily: d, hourly: h)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Cur:Object,Decodable {

    @objc dynamic var time: Date? = nil
    @objc dynamic var summary: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var temperature: Double = 0
    @objc dynamic var apparentTemperature: Double = 0
    @objc dynamic var windSpeed: Double = 0
    
    private enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case temperature
        case apparentTemperature
        case windSpeed
    }
}

class Day:Object, Decodable {
    
    @objc dynamic var summary: String = ""
    @objc dynamic var icon: String = ""
  
    var data = List<D_Data>()

    private enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
    
    convenience init(summary: String, icon: String, data: List<D_Data>) {
        self.init()
        
        self.summary = summary
        self.icon = icon
        self.data = data
    }
    
    convenience required init(from decoder: Decoder) throws {
        let cont = try decoder.container(keyedBy: CodingKeys.self)
        
        let sum = try cont.decode(String.self, forKey: .summary)
        let icon = try cont.decode(String.self, forKey: .icon)
        
        let arr = try cont.decode([D_Data].self, forKey: .data)
        let dataList = List<D_Data>()
        dataList.append(objectsIn: arr)
        
        self.init(summary: sum, icon: icon, data: dataList)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Hour:Object, Decodable {
    
    @objc dynamic var summary: String = ""
    @objc dynamic var icon: String = ""
  
    var data = List<H_Data>()
    
    private enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
    
    convenience init(summary: String, icon: String, data: List<H_Data>) {
        self.init()
        
        self.summary = summary
        self.icon = icon
        self.data = data
    }
    
    convenience required init(from decoder: Decoder) throws {
        let cont = try decoder.container(keyedBy: CodingKeys.self)
        
        let summary = try cont.decode(String.self, forKey: .summary)
        let icon = try cont.decode(String.self, forKey: .icon)
        
        let arr = try cont.decode([H_Data].self, forKey: .data)
        let dataList = List<H_Data>()
        dataList.append(objectsIn: arr)

        self.init(summary: summary, icon: icon, data: dataList)

    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class D_Data:Object, Decodable {
    @objc dynamic var time: Date? = nil
    @objc dynamic var summary: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var windSpeed: Double = 0
    @objc dynamic var temperatureMin: Double = 0
    @objc dynamic var temperatureMax: Double = 0
    @objc dynamic var apparentTemperatureMin: Double = 0
    @objc dynamic var apparentTemperatureMax: Double = 0
    
    private enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case windSpeed
        case temperatureMin
        case temperatureMax
        case apparentTemperatureMin
        case apparentTemperatureMax
    }
}

class H_Data:Object, Decodable {
    @objc dynamic var time: Date? = nil
    @objc dynamic var summary: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var temperature: Double = 0
    @objc dynamic var apparentTemperature: Double = 0
    @objc dynamic var windSpeed: Double = 0

    private enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case temperature
        case apparentTemperature
        case windSpeed
    }
}
