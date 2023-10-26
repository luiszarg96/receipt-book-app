//
//  Receipt.swift
//  receipt-book
//
//  Created by Esteban Perez Castillejo on 22/10/23.
//

import Foundation
import CoreData
import SwiftUI

class ReceiptModelt: ObservableObject {
    
    @Published var ids = UUID()
    @Published var orden:Int16 = 0
    @Published var category = ""
    @Published var minutes = 0
    @Published var nutritionalValue = 0
    @Published var imageCover: Data?
    @Published var nameRecipe = ""
    @Published var contentRecipe = ""
    @Published var updateItem: Receipt!
    @Published var isViewlist = false
    @Published var show = false
    @Published var showItems = false

    //Este metod reorganiza los elementos de lista "List", no funciona con  "LazyVGrid
    func move(from source: IndexSet, to destination: Int, with result: FetchedResults<Receipt>, in context: NSManagedObjectContext){
        var items = Array(result)
        items.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<items.count {
            items[i].orden = Int16(i)
        }
        
        do{
            try context.save()
            print("orden actualizado con exito")
        }catch let error as NSError{
            print("Orden no actualizado", error.localizedDescription)
        }
    }
    
    //este en troria era para mover los elementos dentro del LazyVGrid ,.. pero no funciona
    // lo dejo por si quereis dale una buelta de tuerca
    func moveLazyVGrid(from source: IndexSet, to destination: Int, with result: FetchedResults<Receipt>, context: NSManagedObjectContext){
        var items = result.map{$0}
        items.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<items.count {
            items[i].orden = Int16(i)
        }
        
        do{
            try context.save()
            print("orden actualizado con exito")
        }catch let error as NSError{
            print("Orden no actualizado", error.localizedDescription)
        }
    }
   
    var isFile: [GridItem] = [
        GridItem(.flexible(minimum: 150), spacing: 10),
        GridItem(.flexible(minimum: 150), spacing: 10)
    ]
    
    //Guar dar en coreData
    func seveReceipt(context: NSManagedObjectContext, image: Data){
        
        let newReceipt = Receipt(context: context)
        
        newReceipt.ids = ids
        newReceipt.category = category
        newReceipt.nutritionalValue = Int16(nutritionalValue)
        newReceipt.imageCover = image
        newReceipt.nameRecipe = nameRecipe
        newReceipt.contentRecipe = contentRecipe
        newReceipt.minutes = Int16(minutes)
        
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
        updateItem.nutritionalValue = Int16(item.nutritionalValue)
        updateItem.minutes = Int16(item.minutes)
        updateItem.nameRecipe = item.nameRecipe ?? ""
        updateItem.contentRecipe = item.contentRecipe ?? ""
        showItems.toggle()
    }
    
    //Editar los datos de coreData
    func editReceipt(contex: NSManagedObjectContext){
        updateItem.category = category
        updateItem.imageCover = imageCover
        updateItem.minutes = Int16(minutes)
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
