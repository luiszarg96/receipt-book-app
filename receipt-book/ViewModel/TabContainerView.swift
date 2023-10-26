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
    
    @AppStorage("isEstado") var isEstado: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                TabView{
                    HomeView() // Vista donde se muestra la lista de productos
                        .tabItem {
                            Image(systemName: "house")
                            Text("")
                        }
                        .tag(0)
                    
                    Text("pagina 2") // Renplaza el texto por la vista
                        .tabItem {
                            Image(systemName: "wineglass.fill")
                            Text("")
                        }
                        .tag(1)
                    
                    Text("pagina 3") // Renplaza el texto por la vista
                        .tabItem {
                            Image(systemName: "person.crop.circle")
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
                        
                      /*  Button(action: {
                            isEstado.toggle()
                         
                            print(UserDefaults.standard.string(forKey: "isEstado") ?? Bool())
                        }){
                            Text(model.isViewlist ? "Vista en columna" : "Vista de lista")
                            Image(systemName: model.isViewlist ? "platter.2.filled.ipad.landscape" : "filemenu.and.cursorarrow")
                        }
                        */
                    } label: {
                        Image(systemName: "line.3.horizontal").foregroundColor(Color.white)
                            .imageScale(.large)
                    }
                }
            }
        }
        
       
    }
}


