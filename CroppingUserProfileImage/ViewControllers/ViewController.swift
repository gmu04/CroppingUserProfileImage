// ViewController.swift by Gokhan Mutlu on 28.05.2023

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
				
		setupUI()
	}


	private func setupUI(){
		
		//User can pick their profile picture from the picture gallery or can take it directly via phone's camera
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
			cropProfileImageButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -16),
		])
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.transparentCircleView = TransparentCircleView(frame: profilePhotoImageView.frame)
		view.addSubview(transparentCircleView)
		transparentCircleView.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
		transparentCircleView.layer.opacity = 0.8
		
		let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(changeTransparentCircleScale(_:)))
		self.transparentCircleView.addGestureRecognizer(pinchGestureRecognizer)
		
		let moveGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveTransparentCircle(_:)))
		self.transparentCircleView.addGestureRecognizer(moveGestureRecognizer)
	}
	
	
	@objc private func moveTransparentCircle(_ sender: UIPanGestureRecognizer){
		
		let point = sender.location(in: self.transparentCircleView)
		
		//defining parameters
		let radius 		= self.transparentCircleView.radius
		let thvXMin = point.x - radius
		let thvXMax = point.x + radius
		let thvYMin = point.y - radius
		let thvYMax = point.y + radius
		let padding = self.transparentCircleView.padding
		
		var pointNewX:Double = point.x, pointNewY = point.y
		
		//keep the touch point inside canvas
		if thvXMin <= padding{
			pointNewX = padding + radius
		}
		else if thvXMax >= self.transparentCircleView.bounds.maxX - padding{
			pointNewX = self.transparentCircleView.bounds.maxX - padding - radius
		}
		
		if thvYMin <= padding{
			pointNewY = padding + radius
		}
		else if thvYMax >= self.transparentCircleView.bounds.maxY{
			pointNewY = self.transparentCircleView.bounds.maxY - padding - radius
		}
		self.transparentCircleView.moveCenter(to: CGPoint(x: pointNewX, y: pointNewY))
	}
	
	
	@objc private func changeTransparentCircleScale(_ sender: UIPinchGestureRecognizer){
		switch sender.state {
			case .changed, .ended:
				self.transparentCircleView.radius *= sender.scale
				sender.scale = 1.0
			default:
				break
		}
	}
	
	
	@objc private func cropProfileImage(_ sender:UIButton){
		let img = self.profilePhotoImageView.asImage()
		
		let c = self.transparentCircleView.innerCenter!
		let r = self.transparentCircleView.radius
		let scaleFactor:CGFloat = img.scale
		//print("gmu: c:\(c), r:\(r), scaleFactor:\(scaleFactor)")
		
		let cropZone = CGRect(x: (c.x - r) 	* scaleFactor,
							  y: (c.y - r)	* scaleFactor,
							  width: 2 * r 	* scaleFactor,
							  height: 2 * r * scaleFactor)

		//print("gmu: cropping-rect:\(cropZone)")
		if let image = img.cgImage?.cropping(to: cropZone){
			let tmpUIImage = UIImage(cgImage: image)
			self.profilePhotoCroppedImageView.image = tmpUIImage
			viewModel.saveImage(tmpUIImage)
		}
	}
	
	
	
	
	
	// MARK: - Fields & Properties
	
	private var transparentCircleView:TransparentCircleView!
	private var viewModel = ViewModel()
	
	
	/**
	 User profile image shows
	 */
	private lazy var profilePhotoImageView:UIImageView = {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.backgroundColor = .gray
		//iv.csontentMode = .scaleAspectFill	//default - .scaleToFill
		iv.clipsToBounds = true
		return iv
	}()
	
	
	/**
	 Copped user profile image shows
	 */
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

