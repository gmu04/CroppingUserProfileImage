// ViewModel.swift by Gokhan Mutlu on 30.05.2023

import UIKit

class ViewModel{
	
	func saveImage(_ image:UIImage){
		
		//save cropped image to user photo album
		//UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
		
		//or, store image in a file, db (Core Data), or anywhere you like
		if let imgData = image.jpegData(compressionQuality: 0.8){
			print("data: \(imgData)")
		}
	}
	
}

