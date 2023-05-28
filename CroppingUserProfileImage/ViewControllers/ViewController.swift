// ViewController.swift by Gokhan Mutlu on 28.05.2023

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
				
		setupUI()
	}


	private func setupUI(){
		self.profilePhotoImageView.image = UIImage(named: "user-profile-image")!
		view.addSubview(profilePhotoImageView)
		view.addSubview(profilePhotoCroppedImageView)
		
		self.cropProfileImageButton.addTarget(self, action: #selector(cropProfileImage(_:)), for: .touchUpInside)
		view.addSubview(cropProfileImageButton)
		
		
		let margins = self.view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			profilePhotoImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
			profilePhotoImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
			profilePhotoImageView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 2.2/5),
			profilePhotoImageView.topAnchor.constraint(equalTo: margins.topAnchor),

			profilePhotoCroppedImageView.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 16),
			profilePhotoCroppedImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
			profilePhotoCroppedImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
			profilePhotoCroppedImageView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 1.8 / 5),
			
			cropProfileImageButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
			cropProfileImageButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
			cropProfileImageButton.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.4 / 5),
			cropProfileImageButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
		])
	}
	
	@objc private func cropProfileImage(_ sender:UIButton){
		print("\(#function) tapped")
	}
	
	
	
	
	
	// MARK: - Fields & Properties
	
	private lazy var profilePhotoImageView:UIImageView = {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.backgroundColor = .gray
		//iv.csontentMode = .scaleAspectFill	//default - .scaleToFill
		iv.clipsToBounds = true
		return iv
	}()
	
	
	private lazy var profilePhotoCroppedImageView:UIImageView = {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.backgroundColor = .black
		iv.contentMode = .scaleAspectFit
		iv.clipsToBounds = true
		return iv
	}()
	
	private lazy var cropProfileImageButton:UIButton = {
		let bt = UIButton()
		bt.setTitle("Crop Profile Image", for: .normal)
		bt.backgroundColor = .blue
		bt.setTitleColor(.white, for: .normal)
		bt.translatesAutoresizingMaskIntoConstraints = false
		bt.backgroundColor = .blue
		return bt
	}()

}

