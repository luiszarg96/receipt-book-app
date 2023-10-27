//
//  CustomTextField.swift
//  receipt-book
//
//  Created by lordzzz on 27/10/23.
//
//Este archivo customiza los Text y Image

import SwiftUI

// Cambia y modifica la apariencia de los textos
struct CustomText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Cochin", size: 20)).bold()// Cambia el tamaño y el estilo
            .foregroundColor(Color.red)
            .padding(.leading, 40)
            .padding(.trailing, 10)
            .padding(14)
            .background(Color.white)
            .cornerRadius(15)
            .accentColor(.red)
    }
}

// Cambia modifica la apariencia de imajen
struct CustomImage: ViewModifier {
    
    var valueWidth: CGFloat?
    var valueheight: CGFloat?
    var valueCornerRadius: CGFloat
    var valyePadding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: valueWidth, height: valueheight)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(valueCornerRadius)
            .padding(.top, valyePadding)
            .shadow(color: .black , radius: 3 ,  x: 2 , y: 5)
    }
}

