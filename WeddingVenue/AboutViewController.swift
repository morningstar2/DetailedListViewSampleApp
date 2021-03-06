//  Created by hienng on 12/3/16.
//  Copyright © 2016 chasingkite. All rights reserved.
//
import UIKit

class AboutViewController: UIViewController {

  @IBOutlet weak var contentStackView : UIStackView!
  @IBOutlet weak var showHideButton : UIButton!
  @IBOutlet weak var copyrightStackView: UIStackView!
  
  fileprivate var copyrightContentStackView : UIStackView?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "About"

    contentStackView.isLayoutMarginsRelativeArrangement = true
    contentStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
  }
  
  
  @IBAction func handleShowHideTapped(_ sender: AnyObject) {
    if copyrightContentStackView == nil {
      copyrightContentStackView = createCopyrightInfo()
      copyrightContentStackView?.isHidden = true
      copyrightStackView.addArrangedSubview(copyrightContentStackView!)
      UIView.animate(withDuration: 1.0, animations: {
        self.copyrightContentStackView?.isHidden = false
      }) 
      
    } else {
      UIView.animate(withDuration: 1.0, animations: {
          self.copyrightContentStackView?.isHidden = true
        }, completion: { _ in
          self.copyrightContentStackView?.removeFromSuperview()
          self.copyrightContentStackView = nil
      })
    }
  }
  
  fileprivate func createCopyrightInfo() -> UIStackView {
    let logo = UIImage(named: "fp_logo")
    let logoImageView = UIImageView(image: logo)
    
    let copyrightLabel = UILabel(frame: CGRect.zero)
    copyrightLabel.text = "© FlowerandPaper 2016"
    
    let axisButton = UIButton(type: .roundedRect)
    axisButton.setTitle("Axis Switch", for: UIControlState())
    axisButton.addTarget(self, action: #selector(AboutViewController.switchCopyrightAxis), for: .touchUpInside)
    
    let textStackView = UIStackView(arrangedSubviews: [copyrightLabel, axisButton])
    textStackView.axis = .vertical
    textStackView.spacing = 20.0
    textStackView.alignment = .center
    
    let stackView = UIStackView(arrangedSubviews: [logoImageView, textStackView])
    stackView.axis = .horizontal
    stackView.spacing = 20.0
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    
    return stackView
  }
  
  
  func switchCopyrightAxis() {
    guard let copyrightContentStackView = copyrightContentStackView else {
      return
    }
    
    let newAxis : UILayoutConstraintAxis
    switch copyrightContentStackView.axis {
    case .horizontal:
      newAxis = .vertical
    case .vertical:
      newAxis = .horizontal
    }
    
    UIView.animate(withDuration: 0.7, animations: {
      copyrightContentStackView.axis = newAxis
    }) 
  }
}
