//
//  ImagePicker.swift
//  receipt-book
//
//   Created by lordzzz on 25/10/23.
//

import SwiftUI
import PhotosUI

struct ImagePicker:UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(conexion: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let conexion: ImagePicker
        
        init(conexion: ImagePicker) {
            self.conexion = conexion
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, _ in
                    self.conexion.image = image as? UIImage
                    
                }
            }
        }
        
    }
}

