//
//  AddRecipeView.swift
//  receipt-book
//
//  Created by Esteban Perez Castillejo on 23/10/23.
//

import SwiftUI

struct AddRecipeView: View {
    @ObservedObject var model = ReceiptModelt()
    @Environment (\.managedObjectContext) var context
    @State private var selectedMinutes = 0
    let minuteOptions = Array(0...220) // Opciones de minutos del 0 al 220
    let nutritionalValueOptions = Array(1...900)
    
    var texr = ""
    var body: some View {
        ZStack{
            Color.red
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Find Your Food")
                    .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                    .foregroundColor(Color.white)
                    .padding()
                
                TextField("Nombre de receta", text: $model.nameRecipe)
                    .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                    .foregroundColor(Color.red)
                    .padding(.leading, 40) // Ajusta el valor según sea necesario para dar espacio detrás del botón
                    .padding(.trailing, 10) // Añade un pequeño espacio en el lado derecho si es necesario
                    .padding(14)
                    .background(Color.white)
                    .cornerRadius(15)
                    .accentColor(.red)
                    .padding()
                
                HStack{
                    VStack{
                        Text("Tiempo")
                            .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                            .foregroundColor(Color.red)
                            .padding()
                        Image(systemName: "clock").font(.custom("", size: 60)).padding(10)
                            .foregroundColor(Color.red)
                        
                        // Agregar un Picker para seleccionar minutos
                        Picker("Minutes", selection: $selectedMinutes) {
                            ForEach(minuteOptions, id: \.self) { minute in
                                Text("\(minute) minutes")
                                    .foregroundColor(Color.red)
                                    .tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                    }
                    Image(systemName: "poweron").font(.custom("", size: 100))
                        .foregroundStyle(.red)
                    VStack{
                        Text("Valor kcal")
                            .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                            .foregroundColor(Color.red)
                            .padding()
                        Image(systemName: "chart.bar.xaxis").font(.custom("", size: 60)).padding(10)
                            .border(Color.red, width: 3)
                            .foregroundColor(Color.red)
                        
                        // Agregar un Picker para las kilocalorías.
                        Picker("Kilocalories", selection: $model.nutritionalValue) {
                            ForEach(nutritionalValueOptions, id: \.self) { kcal in
                                Text("\(kcal) kcal")
                                    .foregroundColor(Color.red)
                                    .tag(kcal)
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                }.background(Color.white)
                
                    .cornerRadius(15)
                    .padding()
                TextEditor(text: $model.contentRecipe)
                    .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                    .foregroundColor(Color.red)
                    .padding(.leading, 40) // Ajusta el valor según sea necesario para dar espacio detrás del botón
                    .padding(.trailing, 10) // Añade un pequeño espacio en el lado derecho si es necesario
                    .padding(14)
                    .background(Color.white)
                    .cornerRadius(15)
                    .accentColor(.red)
                    .padding()
                Spacer()
                Button(action: {
                    // Asigna el valor seleccionado al atributo time en tu modelo
                    model.time = model.convertirMinutosEnFecha(minutos: selectedMinutes) ?? Date()
                    model.seveReceipt(context: context) // Guarda el objeto
                    
                }) {
                    Text("Guardar")
                }
            }
            
        }
        
    }
}
