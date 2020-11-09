//
//  ViewModel.swift
//  Map
//
//  Created by 佐藤一成 on 2020/11/01.
//

import Foundation
import SwiftUI

class ViewModel:ObservableObject{
    
    @Published var isLoading:Bool = false
    @Published var isShownSheet:Bool = false
    var conversionData:Model?
    
    func test()->some View{
        func convLat(lat:Double)->String{
            return String(format: "%.2f", lat<0 ? -lat:lat) + (lat<0 ? "S":"N")
        }
        func convLon(lon:Double)->String{
            return String(format: "%.2f", lon<0 ? -lon:lon) + (lon<0 ? "W":"E")
        }
        func convTemp(temp:Double)->String{
            return String(format: "%.1f", temp)
        }
        func convTime(val:TimeInterval)->String{
            let f = DateFormatter()
            f.timeStyle = .medium
            f.dateStyle = .none
            f.locale = Locale(identifier: "ja_JP")
            let dt = Date(timeIntervalSince1970: val)
            return f.string(from: dt)
        }
        
        
        return
            VStack(alignment: .leading, spacing: .none){
                Text("TimeZone:" + conversionData!.timezone)
                Text("緯度/緯度:\(convLat(lat: conversionData!.lat))" + "/\(convLon(lon: conversionData!.lon))")
                Text("現在時刻:\(convTime(val: conversionData!.current.dt))")
                Text("日出時刻:\(convTime(val: conversionData!.current.sunrise))")
                Text("日没時刻:\(convTime(val: conversionData!.current.sunset))")
                Text("気温:\(convTemp(temp: conversionData!.current.temp))℃")
                Text("体感気温:\(convTemp(temp: conversionData!.current.feels_like))℃")
                Text("湿度:\( conversionData!.current.humidity)％")
            }
    }
    
    
    
    
    
    
    func getAPI(lat:Double,long:Double){
        //self.conversionData = nil
        isLoading = true
        let urlString:String = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=1027c365d357ee8897f6cb713c1b33ee&lang=ja&units=metric"
        print(urlString)
        URLSession.shared.dataTask(with: URL(string: urlString)!){(data,response,error) in
            guard let data = data, error == nil else{
                return
            }
            do{
                
                let conversion = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    self.conversionData = conversion
                    self.isLoading = false
                    self.isShownSheet = true
                    print(conversion)
                }
            }catch{
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
                print("error.localizedDescription")
                print(error)
            }
            
        }.resume()
        
        
    }
    
}

struct WeatherViewModel{
    
    
    
}
