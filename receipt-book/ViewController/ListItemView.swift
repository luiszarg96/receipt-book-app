//
//  ListItemView.swift
//  receipt-book
//
//   Created by lordzzz on 27/10/23.
//
// Vista en modo lista

import SwiftUI

struct ListItemView: View {
    
    var item: Receipt // Asegúrate de que Receipt sea el tipo de objeto correcto
    
    @StateObject var model: ReceiptModelt
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationLink(destination: DetailView()) {
            HStack {
                
                Image(uiImage: UIImage(data: item.imageCover ?? Data())!)
                    .resizable()
                    .modifier(CustomImage(valueWidth: 55, valueheight: 55, valueCornerRadius: 100, valyePadding: -6))// llamas al modificadorr desde otra estructura
                
                VStack(alignment: .leading){
                    Text(item.nameRecipe ?? "").font(.custom("Cochin", size: 16)).bold()
                    HStack{
                        Image(systemName: "clock").foregroundColor(Color.red)
                        Text("\(Int16(item.minutes)) minu, ")
                        Image(systemName: "chart.bar.xaxis").foregroundColor(Color.red)
                        Text("\(Int16(item.nutritionalValue)) Ckal.")
                    }
                }
                
            }
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                model.deleteReceipt(item: item, context: context)
            }) {
                Image(systemName: "trash")
            }
        }
        .tint(Color.red)
        .cornerRadius(10)
        .padding()
        .swipeActions(edge: .trailing) {
            Button(action: {
                // Logica para editar
            }) {
                Image(systemName: "square.and.pencil")
            }
        }
        .tint(Color.red)
        .cornerRadius(10)
        .padding()
    }
}
