//
//  AddRecipeView.swift
//  receipt-book
//
//  Created by lordzzz on 23/10/23.
//

import SwiftUI

struct AddRecipeView: View {
    
    @ObservedObject var model:  ReceiptModelt
    @Environment (\.managedObjectContext) var context
    @State private var selectedMinutes = 0
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showImagePicker = false
    
    let minuteOptions = Array(0...220) // Opciones de minutos del 0 al 220
    let nutritionalValueOptions = Array(1...900)
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }

    var body: some View {
        ZStack{
            Color.red
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                HStack{
                    Spacer()
                    Button(action: {
                        model.show = false
                        model.nameRecipe = ""
                        model.contentRecipe = ""
                        model.nutritionalValue = 0
                    }){
                        Image(systemName: "xmark.square.fill").font(.custom("", size: 20))
                            .foregroundStyle(Color.red)
                            .shadow(radius: 20)
                    }.padding(4)
                }.background(Color.white)
                    .shadow(radius: 20)
                
                
                Text("Find Your Food, Receipt Save")
                    .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                    .foregroundColor(Color.white)
                    .padding()
                
                image?
                    .resizable()
                    .scaledToFill()
                    .background(Color.white)
                    .modifier(CustomImage(valueWidth: 100, valueheight: 100, valueCornerRadius: 100, valyePadding: 0))// llamas al modificadorr desde otra estructura
                    .shadow(radius: 20)
                    
                ZStack{
                    TextField("Nombre de receta", text: $model.nameRecipe)
                        .modifier(CustomText())// LLamo ala esctructura donde esta los modificadores
                        .padding()
                    HStack{
                        
                    Spacer()
                        Button{
                            showImagePicker = true
                        } label:{
                            Image(systemName: "photo.badge.plus")
                                .foregroundStyle(Color.red)
                        }.padding(30)
                        
                        .onChange(of: inputImage) { _ in
                            loadImage()
                        }
                        
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $inputImage)
                        }
                    }
                }
                HStack{
                    VStack{
                        Text("Tiempo")
                            .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
                            .foregroundColor(Color.red)
                            .padding()
                        
                        Image(systemName: "clock").font(.custom("", size: 40))
                            .foregroundColor(Color.red)
                        
                        // Agregar un Picker para seleccionar minutos
                        Picker("Minutes", selection: $model.minutes) {
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
                        Image(systemName: "chart.bar.xaxis").font(.custom("", size: 30))
                            .padding(5)
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
                    .modifier(CustomText())// LLamo ala esctructura donde esta los modificadores
                    .padding()
                Spacer()
                Button(action: {
                    var imageData: Data?
                        if let inputImage = inputImage {
                            imageData = inputImage.pngData() // Convierte UIImage a Data en formato PNG
                        } else {
                            // Si no hay una imagen, agrega imagen por defecto
                            if let defaultImage = UIImage(named: "default") {
                                imageData = defaultImage.pngData()
                            }
                        }

                        // Llama al método seveReceipt con la imagen (puede ser la imagen por defecto si no hay una imagen)
                        if let imageData = imageData {
                            model.seveReceipt(context: context, image: imageData)
                        }
                    model.show = false
                    model.nameRecipe = ""
                    model.contentRecipe = ""
                    model.nutritionalValue = 0
                    
                }) {
                    Text("Guardar")
                        .font(.custom("Cochin", size: 20)).bold()
                        .foregroundStyle(model.contentRecipe == "" ? Color.white : Color.red)
                    
                }.padding()
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .background(model.contentRecipe == "" ? Color.gray : Color.white)
                    .cornerRadius(8)
                    .disabled(model.contentRecipe == "" ? true : false)
                    .shadow(radius: 20)
            }
        }
    }
}

