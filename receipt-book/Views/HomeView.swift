//
//  Home.swift
//  receipt-book
//
//  Created by Luis Zarza on 2023-10-19.
//

import SwiftUI

struct HomeView: View {
    
    @State var showToobar = false
    @State var isSeeker = ""
    
    var body: some View {
        VStack{
            ZStack{
                //LinearGradient(gradient: Gradient(colors: [ Color.red.opacity(0.2),Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                            
                        }){
                            Image(systemName: "magnifyingglass")
                        }.offset(x: -150)
                        
                    }
                    Spacer()
                    
                    List{
                        // Listado de productos
                    }
                    
                }.padding()
            }
        }
        .padding(.bottom, 30)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
