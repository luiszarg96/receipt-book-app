//
//  Home.swift
//  receipt-book
//
//  Created by Luis Zarza on 2023-10-19.
//

import SwiftUI

struct HomeView: View {
    @StateObject var model = ReceiptModelt()
    @Environment (\.managedObjectContext) var context
    @EnvironmentObject var receiptModelt: ReceiptModelt
    
    @FetchRequest(entity: Receipt.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Receipt.orden, ascending: true)], animation: .spring) var result: FetchedResults<Receipt>
    
    @State var cambio: Double = 0.5
    @State var showToobar = false
    @State var isSeeker = ""
    
    @Binding var isViewlist: Bool
    
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
                //Obción de fondo con degradado
                //  LinearGradient(gradient: Gradient(colors: [ Color.red.opacity(cambio),Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Color.red
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    //Titulo de la vista
                    Text("Find Your Food")
                        .font(.custom("Cochin", size: 40)).bold()// Cambia el tamaño y el estilo
                        .foregroundColor(Color.white)
                        .shadow(color: .black , radius: 3 ,  x: 2 , y: 5)// da el efecto de sombra
                    
                    //Buscaror .....
                    ZStack{
                        TextField("What foo for today ...", text: $isSeeker)
                            .foregroundColor(Color.red)
                            .padding(.leading, 40) // Ajusta el valor según sea necesario para dar espacio detrás del botón
                            .padding(.trailing, 10) // Añade un pequeño espacio en el lado derecho si es necesario
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(15)
                            .accentColor(.red)
                        
                        Button(action: {
                            // Logica para buscar
                            isSeeker = isSeeker.trimmingCharacters(in: .whitespacesAndNewlines)
                        }){
                            Image(systemName: "magnifyingglass")
                        }.offset(x: -150)
                        
                    }
                    
                    Spacer()
                    if isViewlist != false {
                        //ESte el estilo de Vista
                        List{
                            ForEach(filteredResult){item in
                                NavigationLink(destination: DetailView()){
                                    HStack{
                                        Image(uiImage: UIImage(data: item.imageCover ?? Data())!)
                                            .resizable()
                                            .frame(width: 55, height: 55)
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(100)
                                            .shadow(color: .black , radius: 3 ,  x: 2 , y: 5)
                                            .padding(.top, -6)
                                        
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
                                .swipeActions(edge: .leading){
                                    
                                    Button(action: {
                                        model.deleteReceipt(item: item, context: context)
                                    }){
                                        Image(systemName: "trash")
                                    }
                                    
                                }
                                .tint(Color.red).cornerRadius(10).padding()
                                .swipeActions(edge: .trailing){
                                    
                                    Button(action: {
                                        //Logica para editar
                                    }){
                                        Image(systemName: "square.and.pencil")
                                    }
                                    
                                }
                                .tint(Color.red).cornerRadius(10).padding()
                                
                            }//.padding(5)
                            .onMove(perform: { indice, newOffse in
                                model.move(from: indice, to: newOffse, with: result, in: context)
                            })
                            .listRowBackground(Color.clear)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            
                            
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
                                    NavigationLink(destination: DetailView()){
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white)
                                                .frame(width: 150, height: 190) // Altura de la tarjeta y anchura
                                                .offset(x: 0, y: 20)
                                                .shadow(color: .black.opacity(0.5) , radius: 3 ,  x: 2 , y: 5)
                                            Image(uiImage: UIImage(data: item.imageCover ?? Data())!)
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .aspectRatio(contentMode: .fit)
                                                .cornerRadius(100)
                                                .padding(.top, -135)
                                                .shadow(color: .black , radius: 3 ,  x: 2 , y: 5)
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
