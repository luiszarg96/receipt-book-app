//
//  Home.swift
//  receipt-book
//
//  Created by Luis Zarza on 2023-10-19, and edit for lordzz.
//

import SwiftUI

struct HomeView: View {
    @StateObject var model = ReceiptModelt()
    @Environment (\.managedObjectContext) var context
    @EnvironmentObject var receiptModelt: ReceiptModelt
    
    @FetchRequest(entity: Receipt.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Receipt.orden, ascending: true)], animation: .spring) var result: FetchedResults<Receipt>
    
    @State var isSeeker = ""
    
    @Binding var isViewlist: Bool
    @Binding var colorChangeKey: Bool
    
    //Logica para el buscador
    var filteredResult: [Receipt]{
        if isSeeker.isEmpty{
            return Array(result)
        }else{
            return result.filter{ result in
                
                //aqui se inserta los filtros para el buscador
                let nameReceipt = result.nameRecipe?.localizedCaseInsensitiveContains(isSeeker) ?? false
                return nameReceipt
            }
        }
    }
    
    var body: some View {
        
        VStack{
            ZStack{
                if colorChangeKey != false{
                    //Obción de fondo con degradado
                   LinearGradient(gradient: Gradient(colors: [ Color.red,Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                }else{
                    Color.red
                        .edgesIgnoringSafeArea(.all)
                }
                    
                VStack(alignment: .leading){
                    //Titulo de la vista
                    Text("Find Your Food")
                        .font(.custom("Cochin", size: 40)).bold()// Cambia el tamaño y el estilo
                        .foregroundColor(Color.white)
                        .shadow(color: .black , radius: 3 ,  x: 2 , y: 5)// da el efecto de sombra
                    
                    //Buscaror .....
                    ZStack{
                        TextField("What foo for today ...", text: $isSeeker)
                            .modifier(CustomText())
                        Button(action: {
                            // Logica para buscar
                            isSeeker = isSeeker.trimmingCharacters(in: .whitespacesAndNewlines)
                        }){
                            Image(systemName: "magnifyingglass")
                        }.offset(x: -150)
                    }
                    Spacer()
                    
                    if isViewlist != false {
                        List{
                            ForEach(filteredResult) { item in
                                ListItemView(item: item, model: model)
                                
                                    .listRowBackground(Color.clear)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            }
                            .onMove(perform: { indice, newOffse in
                                model.move(from: indice, to: newOffse, with: result, in: context)
                            })
                        }.padding(.leading,-15)
                            .padding(.trailing,-15)
                            .listStyle(PlainListStyle())
                            .foregroundColor(.red)
                            .cornerRadius(10)
                    }else{
                        //  Este es estilo de columnas
                        ScrollView{
                            LazyVGrid(columns: model.isFile, spacing: 5){
                                ForEach(filteredResult){item in
                                    LazyVGridView(item: item, model: model)
                                }
                                .padding(5)
                            }
                            
                        }
                        
                    }
                }.padding()
            }
        }
        .padding(.bottom, 30)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isViewlist: .constant(false), colorChangeKey: .constant(false))
    }
}
