//
//  BottomSheet.swift
//  Map
//
//  Created by 佐藤一成 on 2020/11/09.
//

import SwiftUI

struct BottomSheet:View{
    @State var txt = ""
    var body:some View{
        VStack{
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(alignment: .leading, spacing: 15){
                    ForEach(1...15, id: \.self) { count in
                        Text("Searched Place \(count)")
                        Divider()
                            .padding(.top,10)
                    }
                }
                .padding()
                .padding(.top)
            })
            
        }
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
}
