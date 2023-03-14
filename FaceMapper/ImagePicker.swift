//
//  ImagePicker.swift
//  FaceMapper
//
//  Created by Bahadır Ersin on 14.03.2023.
//
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var image:UIImage?
    @Binding var addInfo:Bool
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        
        var parent:ImagePicker
        
        init(_ parent:ImagePicker){
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else {
                return
            }
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, _ in
                    self.parent.image = image as? UIImage
                    self.parent.addInfo = true
                }
            }
        }
        
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//        do nothing
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
