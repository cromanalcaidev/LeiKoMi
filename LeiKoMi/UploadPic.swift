//
//  UploadPic.swift
//  LeiKoMi
//
//  Created by Carlos Román Alcaide on 11/5/24.
//

import CoreImage
import PhotosUI
import SwiftUI

struct UploadPic: View {
    @State private var finalImage: Image?
    @State private var pickedImage: PhotosPickerItem?
    @State private var pictures = Pictures()
    
    
    var body: some View {
        
        VStack {
            PhotosPicker(selection: $pickedImage) {
                if let finalImage {
                    finalImage
                        .resizable()
                        .scaledToFit()
                    
                } else {
                    ContentUnavailableView("Post a pic", systemImage: "photo.badge.plus")
                }
            }
            .onChange(of: pickedImage, postPic)
        }
        .padding(.vertical, 10)
        
        if let finalImage {
            Text("My input")
        }
    }
    
    func postPic() {
        Task {
            guard let importedDataPic = try await pickedImage?.loadTransferable(type: Data.self) else { return }
            guard let picFromData = UIImage(data: importedDataPic) else { return }
            finalImage = Image(uiImage: picFromData)
        }
    }
}

#Preview {
    UploadPic()
}
