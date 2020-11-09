//
//  ContentView.swift
//  Map
//
//  Created by 佐藤一成 on 2020/11/01.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var isShownSheet:Bool = false
    @State private var region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.655164046, longitude: 139.740663704), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @ObservedObject var viewModel:ViewModel = ViewModel()
    
    var body: some View {
        ZStack{
           
                Map(coordinateRegion: $region)
                
                    /*
            ZStack{
                if self.viewModel.isLoading{
                    ProgressView("Loading")
                }else{
                Circle()
                    .frame(width: 60.0, height: 60.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(self.viewModel.isLoading ? .red : .blue)
                    .opacity(0.5)
                Text("天気を取得")
                    .font(.caption)
                }
                    
            }
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/){
                
                
                self.viewModel.getAPI(lat: region.center.latitude, long: region.center.longitude)
            }
            */
            .sheet(isPresented: self.$viewModel.isShownSheet){
                VStack{
                    
                    self.viewModel.test()
                    
                }
 
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
