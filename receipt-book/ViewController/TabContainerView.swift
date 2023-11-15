//
//  TabContainerView.swift
//  receipt-book
//
//  Created by Luis Zarza on 2023-10-21.
//

import SwiftUI

struct TabContainerView: View {
    
    @ObservedObject var model = ReceiptModelt()
    @Environment (\.managedObjectContext) var context
    @EnvironmentObject var receiptModelt: ReceiptModelt
    
    init() {
            // Recupera el estado de UserDefaults al iniciar la vista
            if let savedIsViewlist = UserDefaults.standard.value(forKey: "isViewlistKey") as? Bool {
                model.isViewlist = savedIsViewlist
            }
        
            if let seveColorChange = UserDefaults.standard.value(forKey: "colorChangeKey") as? Bool {
                model.colorChange = seveColorChange
            }
        }
    
   // @AppStorage("isEstado") var isEstado: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                TabView{
                    HomeView(isViewlist: $model.isViewlist, colorChangeKey: $model.colorChange) // Vista donde se muestra la lista de productos
                        .tabItem {
                            Image("home")
                            Text("")
                        }
                        .tag(0)
                    
                    Text("pagina 2") // Renplaza el texto por la vista
                        .tabItem {
                            Image("drink")
                            Text("")
                        }
                        .tag(1)
                    
                    Text("pagina 3") // Renplaza el texto por la vista
                        .tabItem {
                            Image("folder")
                            Text("")
                        }
                        .tag(2)
                }
                .accentColor(.red)
                
                //Ventana modal para agregar las recetas
                .sheet(isPresented: $model.show){
                    AddRecipeView(model: model)
                }
                
            }
            .accentColor(.red)
            .toolbar{
                ToolbarItem(placement: .navigation) {
                    
                    Menu{
                        Button(action: {
                            model.show = true
                        }){
                            Text("Nueva Receta")
                            Image(systemName: "note.text.badge.plus")
                        }
                        
                        Button(action: {
                            model.isViewlist.toggle()
                            UserDefaults.standard.set(model.isViewlist, forKey: "isViewlistKey")

                            
                        }){
                            Text(model.isViewlist ? "Vista en columna" : "Vista de lista")
                            Image(systemName: model.isViewlist ? "platter.2.filled.ipad.landscape" : "filemenu.and.cursorarrow")
                           
                        }
                        
                        Button(action: {
                            model.colorChange.toggle()
                            UserDefaults.standard.setValue(model.colorChange, forKey: "colorChangeKey")
                        }){
                            Text("Cambiar Estilo de fondo")
                            Image(systemName: "swatchpalette")
                        }
                        
                    } label: {
                        Image(systemName: "line.3.horizontal").foregroundColor(Color.white)
                            .imageScale(.large)
                    }
                }
            }
        }
        
       
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}
