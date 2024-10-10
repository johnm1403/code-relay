//
//  DetailsView.swift
//  Code Relay
//
//  Created by Sebastian Bolling on 2024-10-08.
//

import SwiftUI
import MapKit

struct DetailsView: View {
   
    @State private var showCheekyPrawn = false
    @State private var showConfetti = false
    @State var location: Location
    
    var body: some View {
        ZStack {
            VStack {
                Map(initialPosition: .region(
                    MKCoordinateRegion(
                        center: location.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), 
                        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    )
                ))
                .frame(height: 400)
                .frame(maxWidth: .infinity)               
                
                Text(location.title).fontWeight(.bold)
                Text(location.details).onTapGesture { toggleCheekyPrawn() }
                if showCheekyPrawn {
                    Text("🦐").font(.largeTitle)
                }
                
                Spacer()
                
                if let phoneNumber = location.phoneNumber {
                    Link("Call", destination: URL(string: "tel:\(phoneNumber)")!)
                        .padding()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)

            if showCheekyPrawn && showConfetti {
                PrawnConfettiView(
                    numberOfConfetti: 200, 
                    animationDuration: 1,
                    onComplete: { 
                        showConfetti = false
                    }
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
    }

    private func toggleCheekyPrawn() {
        showCheekyPrawn.toggle()
        showConfetti = showCheekyPrawn
    }
}
