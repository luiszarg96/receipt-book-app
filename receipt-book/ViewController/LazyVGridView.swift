//
//  LazyVGridView.swift
//  receipt-book
//
//   Created by lordzzz on 27/10/23.
//
// Vista de  columnas

import SwiftUI

struct LazyVGridView: View {
    
    var item: Receipt
    
    @StateObject var model: ReceiptModelt
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationLink(destination: DetailView()){
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 150, height: 190) // Altura de la tarjeta y anchura
                    .offset(x: 0, y: 20)
                    .shadow(color: .black.opacity(0.5) , radius: 3 ,  x: 2 , y: 5)
                Image(uiImage: UIImage(data: item.imageCover ?? Data())!)
                    .resizable()
                    .modifier(CustomImage(valueWidth: 120, valueheight: 120, valueCornerRadius: 100, valyePadding: -135))// llamas al modificadorr desde otra estructura
                VStack{
                    Spacer()
                    Text(item.nameRecipe ?? "").font(.custom("Cochin", size: 16)).bold()
                        .padding()
                    HStack{
                        
                        VStack{
                            Image(systemName: "clock").font(.system(size: 16)).foregroundColor(Color.red)
                            Text("\(Int16(item.minutes)) minu, ").font(.custom("Cochin", size: 16)).bold()
                        }
                        Rectangle()
                            .frame(width: 2, height: 50) // Ancho y alto de la línea
                            .cornerRadius(2.5) // Radio de los bordes redondeados (mitad del ancho)
                            .foregroundColor(Color.red) // Color de la línea
                        
                        VStack{
                            Image(systemName: "chart.bar.xaxis").font(.system(size: 16)).foregroundColor(Color.red)
                            Text("\(Int16(item.nutritionalValue)) Ckal.").font(.custom("Cochin", size: 16)).bold()
                        }
                    }
                }
            }.padding(.top, 55)
        }
        .contextMenu{
            
            Button(action: {
                //
            }){
                Text("Editar")
                Image(systemName: "square.and.pencil")
            }
            
            Button(action: {
                
                model.deleteReceipt(item: item , context: context)
            }){
                Text("Eliminar")
                Image(systemName: "trash")
            }
        }
    }
}
