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
        let newReceipt = Receipt(context: context)
        newReceipt.ids = ids
        newReceipt.category = category
        newReceipt.time = time
        newReceipt.nutritionalValue = Int16(nutritionalValue)
        newReceipt.imageCover = imageCover
        newReceipt.nameRecipe = nameRecipe
        newReceipt.contentRecipe = contentRecipe
        
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
}
