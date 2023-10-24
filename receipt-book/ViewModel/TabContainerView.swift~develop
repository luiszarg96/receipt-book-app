//
//  TabContainerView.swift
//  receipt-book
//
//  Created by Luis Zarza on 2023-10-21.
//

import SwiftUI

struct TabContainerView: View {
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
            }
            
            .toolbar{
                ToolbarItem(placement: .navigation) {
                    Menu{
                        Button(action: {
                            ///
                        }){
                            Text("Holaa")
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