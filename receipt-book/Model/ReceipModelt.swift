//
//  Receipt.swift
//  receipt-book
//
//  Created by Esteban Perez Castillejo on 22/10/23.
//

import Foundation
import CoreData

class ReceiptModelt: ObservableObject {
    
    @Published var ids = UUID()
    @Published var category = ""
    @Published var time = Date()
    @Published var nutritionalValue = 0
    @Published var imageCover: Data?
    @Published var nameRecipe = ""
    @Published var contentRecipe = ""
    @Published var updateItem: Receipt!
    @Published var show = false
    @Published var showItems = false
    
    //Guar dar en coreData
    func seveReceipt(context: NSManagedObjectContext){
        let minutosDeseados = 120 // Cambia esto al valor de minutos que desees
        let newReceipt = Receipt(context: context)
        
        newReceipt.ids = ids
        newReceipt.category = category
        newReceipt.nutritionalValue = Int16(nutritionalValue)
        newReceipt.imageCover = imageCover
        newReceipt.nameRecipe = nameRecipe
        newReceipt.contentRecipe = contentRecipe
        
        // Convierte los minutos en una fecha y asigna a la propiedad time
            if let fechaConvertida = convertirMinutosEnFecha(minutos: minutosDeseados) {
                newReceipt.time = fechaConvertida
            } else {
                // Maneja el caso en el que la conversión no sea posible
                // Puedes mostrar un mensaje de error o tomar alguna otra acción
                print("No se pudo realizar la conversión de minutos a fecha")
            }
        
        do{
            try context.save()
            print("Guardado con exito")
            show.toggle()
        }catch let error as NSError{
            print("No se a podido guardar",error.localizedDescription)
        }
        
    }
    
    //Traer los Datos de corData
    func sentReceipt(item: Receipt){
        updateItem = item
        updateItem.category = item.category ?? ""
        updateItem.imageCover = item.imageCover ?? Data()
        updateItem.time = item.time ?? Date()
        updateItem.nutritionalValue = Int16(item.nutritionalValue)
        updateItem.nameRecipe = item.nameRecipe ?? ""
        updateItem.contentRecipe = item.contentRecipe ?? ""
        showItems.toggle()
    }
    
    //Editar los datos de coreData
    func editReceipt(contex: NSManagedObjectContext){
        updateItem.category = category
        updateItem.imageCover = imageCover
        updateItem.time = time
        updateItem.nutritionalValue = Int16(nutritionalValue)
        updateItem.nameRecipe = nameRecipe
        updateItem.contentRecipe = contentRecipe
        
        do{
            try contex.save()
            print("cambios realizado con exito")
            showItems.toggle()
        }catch let error as NSError {
            print("no datos no se han actualizado", error.localizedDescription)
        }
        
    }
    
    // Eliminar los datos de core data
    func deleteReceipt(item: Receipt, context: NSManagedObjectContext){
        context.delete(item)
        
        do{
            try context.save()
            print("borrado con exito")
        }catch let error as NSError{
            print("No se a posido borrar", error.localizedDescription)
        }
    }
    
    //Funcion para combertir enteros en medida de tiempos en minutos
    func convertirMinutosEnFecha(minutos: Int) -> Date? {
           // Especifica la fecha de referencia (puedes ajustar esto según tus necesidades)
           let fechaDeReferencia = Date()

           // Crea un objeto Calendar
           let calendar = Calendar.current

           // Realiza la conversión de minutos a una fecha
           if let fechaConvertida = calendar.date(byAdding: .minute, value: minutos, to: fechaDeReferencia) {
               return fechaConvertida
           } else {
               return nil  // En caso de que la conversión no sea posible
           }
       }
}
