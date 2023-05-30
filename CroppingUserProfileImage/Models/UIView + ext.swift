// UIView + ext.swift by Gokhan Mutlu on 30.05.2023

import UIKit

extension UIView {
	func asImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(bounds: bounds)
		return renderer.image { rendererContext in
			layer.render(in: rendererContext.cgContext)
		}
	}
}
