//
//  CardView.swift
//  receipt-book
//
//  Created by Esteban Perez Castillejo on 25/10/23.
//

import SwiftUI

struct CardView: View {
    
    var nameRecipe: String
    var nutritionalValue: Int16
    var minutes: Int16
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: 200, height: 170) // Altura de la tarjeta
                .offset(x: 0, y: 30)
                .shadow(radius: 5)
            VStack{
                Text(nameRecipe)
                    .font(.custom("Cochin", size: 20)).bold()
                    .foregroundColor(Color.red)
                HStack{
                    Image(systemName: "clock").foregroundColor(Color.red)
                    Text("\(Int16(minutes)) minu, ")
                    Image(systemName: "chart.bar.xaxis").foregroundColor(Color.red)
                    Text("\(Int16(nutritionalValue)) Ckal.")
                }
            }
        }
    }
}
