//
//  ContentView.swift
//  Map
//
//  Created by 佐藤一成 on 2020/11/01.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID()
    let name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
      CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
  }




struct ContentView: View {
    
    @State var count:Int = 0
    @State var position = CLLocationCoordinate2D()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @State private var isShownSheet:Bool = false
    @State private var region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.655164046, longitude: 139.740663704), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    var annotation = MKPointAnnotation()
    
    @State var pinPlacce = [Place]()
    
    
    
    
    
    
    @State var offset:CGFloat = UIScreen.main.bounds.maxY-70
    @ObservedObject var viewModel:ViewModel = ViewModel()
    
    var body: some View {
        ZStack{
            
            Map(coordinateRegion: $region,annotationItems: pinPlacce) { place in
                MapMarker(coordinate: place.coordinate, tint: .none)}
                .ignoresSafeArea(.all, edges: .all)
            VStack{
                Text("\(self.count)")
            }
            GeometryReader{geometry in
                VStack{
                    BottomSheet()
                        .offset(x: 0.0, y: offset)
                        .gesture(DragGesture()
                                    .onChanged{ value in
                                        withAnimation{
                                            offset = value.location.y
                                        }
                                    }.onEnded({value in
                                        print(offset)
                                        withAnimation{
                                            if offset < UIScreen.main.bounds.maxY/2-30{
                                                offset = UIScreen.main.bounds.maxY/2-30
                                            }
                                            if offset > UIScreen.main.bounds.maxY-70{
                                                offset = UIScreen.main.bounds.maxY-70
                                            }
                                        }
                                    })
                        )
                }
            }
            .sheet(isPresented: self.$viewModel.isShownSheet){
                VStack{
                    self.viewModel.test()
                }
                
            }
        }
        .onReceive(timer){ input in
            
            if (self.position.latitude == self.region.center.latitude) && (self.position.longitude == self.region.center.longitude){
                self.count += 1
                if self.count == 3{
                    let lat:Double = self.region.center.latitude
                    let lon:Double = self.region.center.longitude
                    pinPlacce.removeAll()
                    pinPlacce.append(Place(name: "name", latitude: lat, longitude: lon))
                    self.viewModel.getAPI(lat: lat, long: lon)
                }
            }else{
                self.position = self.region.center
                self.count = 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
