// TransparentCircleView.swift by Gokhan Mutlu on 30.05.2023

import UIKit

class TransparentCircleView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
		super.draw(rect)
		
//		if self.innerCircleView != nil{
			self.backgroundColor?.setFill()
			UIRectFill(rect)
			
			let path = CGMutablePath()
			//path.addRect(self.innerCircleView.frame)
			
			// make a circle in view's overlay
			
			
			path.addArc(center: self.innerCenter!,
						radius: self.radius,
						startAngle: 0, endAngle: 2 * .pi, clockwise: false)
			path.addRect(bounds)

			
			let layer = CAShapeLayer()
			layer.path = path
			layer.fillRule = CAShapeLayerFillRule.evenOdd
			self.layer.mask = layer
//		}
    }

	
	//MARK: - init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		customInit()
	}
	
	required init?(coder: NSCoder) {
		//fatalError("init(coder:) has not been implemented")
		super.init(coder: coder)
		customInit()
	}
	
	private func customInit(){
		self.maxPerimeterOfCircle = min(self.frame.width, self.frame.height) - (2 * padding)
		//max radius would be half of the self.maxPerimeterOfCircle.
		self.radius = self.maxPerimeterOfCircle / 2.5
	}

	

	//MARK: - Fields & properties
	
//	private var innerCircleView: UIView!
	private var maxPerimeterOfCircle:CGFloat = 0
	let padding:CGFloat = 2		//padding of square - in which we draw transparent circle
	var innerCenter:CGPoint?
	
	
	var radius:CGFloat = 0 {
		didSet{
			if (2 * radius) <= maxPerimeterOfCircle{

				//calculate the rectange frame for the circle drawn
				let x:CGFloat = (self.bounds.width / 2) - radius
				let y:CGFloat = (self.bounds.height / 2) - radius
				let rect = CGRect(x: x, y: y, width:  2 * radius, height: 2 * radius)
				
				self.innerCenter = UIView(frame: rect).center
				self.draw(self.frame)
			}else{
				radius = oldValue
			}
		}
	}
	
}
