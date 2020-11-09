//
//  Model.swift
//  Map
//
//  Created by 佐藤一成 on 2020/11/01.
//

import Foundation

struct Model:Codable{
    var lat:Double
    var lon:Double
    var timezone:String
    var timezone_offset:TimeInterval
    var current:Current
    var minutely:[Minutely]?
    var hourly:[Hourly]
    var daily:[Daily]
    var alerts:[Alerts]?
}

struct Current:Codable{
    var dt:TimeInterval
    var sunrise:TimeInterval
    var sunset:TimeInterval
    var temp:Double
    var feels_like:Double
    var pressure:Int
    var humidity:Int
    var dew_point:Double
    var clouds:Int
    var uvi:Double?
    var visibility:Int
    var wind_speed:Double
    var wind_gust:Double?
    var wind_deg:Double
    var rain:Rain?
    var snow:Snow?
    var weather:[Weather]
}

struct Snow:Codable{
    var oneHour:Double
    private enum CodingKeys:String, CodingKey{
        case oneHour = "1h"
    }
}

struct Rain:Codable{
    var oneHour:Double
    private enum CodingKeys:String, CodingKey{
        case oneHour = "1h"
    }
}

struct Weather:Codable{
    var id:Int
    var main:String
    var description:String
    var icon:String
}

struct Minutely:Codable{
    var dt:TimeInterval
    var precipitation:Double
}

struct Hourly:Codable{
    var dt:TimeInterval
    var temp:Double
    var feels_like:Double
    var pressure:Int
    var humidity:Int
    var dew_point:Double
    var clouds:Int
    var visibility:Int
    var wind_speed:Double
    var wind_gust:Double?
    var wind_deg:Double
    var pop:Double
    var rain:Rain?
    var snow:Snow?
    var weather:[Weather]
}


struct Daily:Codable{
    var dt:TimeInterval
    var sunrise:TimeInterval
    var sunset:TimeInterval
    var temp:Temp
    struct Temp:Codable{
        var morn:Double
        var day:Double
        var eve:Double
        var night:Double
        var min:Double
        var max:Double
    }
    var feels_like:Feel_like
    struct Feel_like:Codable{
        var morn:Double
        var day:Double
        var eve:Double
        var night:Double
    }
    var pressure:Int
    var humidity:Int
    var dew_point:Double
    var wind_speed:Double
    var wind_gust:Double?
    var wind_deg:Double
    var clouds:Int
    var uvi:Double?
    var visibility:Int?
    var pop:Double
    var rain:Double?
    var snow:Double?
    var weather:[Weather]
}

struct Alerts:Codable{
    var sender_name:String
    var event:String
    var start:TimeInterval
    var end:TimeInterval
    var description:String
}
