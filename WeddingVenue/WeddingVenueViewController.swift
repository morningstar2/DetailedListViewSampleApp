//  Created by hienng on 12/3/16.
//  Copyright © 2016 chasingkite. All rights reserved.
//

import UIKit
import MapKit

class WeddingVenueViewController : UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var priceGuideLabel: UILabel!
  @IBOutlet weak var ratingImage: UIImageView!
  @IBOutlet weak var showDetailsButton: UIButton!
  @IBOutlet weak var showMapButton: UIButton!


  var weddingVenue : WeddingVenue? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let weddingVenue = weddingVenue {
      nameLabel?.text = weddingVenue.name
      imageView?.image = weddingVenue.photo ?? UIImage(named: "placeholder")
      detailsLabel?.text = weddingVenue.details
      priceGuideLabel?.text = "\(weddingVenue.priceGuide)"
      ratingImage?.image = weddingVenue.rating.ratingImage
      centreMap(mapView, atPosition: weddingVenue.location)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  @IBAction func handleShowDetailsButtonPressed(_ sender: UIButton) {
    if detailsLabel.isHidden {
      animateView(detailsLabel, toHidden: false)
      showDetailsButton.setTitle("Hide Details", for: UIControlState())
    } else {
      animateView(detailsLabel, toHidden: true)
      showDetailsButton.setTitle("Show Details", for: UIControlState())
    }
  }
  
  @IBAction func handleShowMapButtonPressed(_ sender: UIButton) {
    if mapView.isHidden {
      animateView(mapView, toHidden: false)
      showMapButton.setTitle("Hide Map", for: UIControlState())
    } else {
      animateView(mapView, toHidden: true)
      showMapButton.setTitle("Show Map", for: UIControlState())
    }
  }

  fileprivate func animateView(_ view: UIView, toHidden hidden: Bool) {
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(), animations: { () -> Void in
      view.isHidden = hidden
      }, completion: nil)
  }
  
  
  fileprivate func centreMap(_ map: MKMapView?, atPosition position: CLLocationCoordinate2D?) {
    guard let map = map,
      let position = position else {
        return
    }
    map.isZoomEnabled = false
    map.isScrollEnabled = false
    map.isPitchEnabled = false
    map.isRotateEnabled = false
    
    map.setCenter(position, animated: true)
    
    let zoomRegion = MKCoordinateRegionMakeWithDistance(position, 10000, 10000)
    map.setRegion(zoomRegion, animated: true)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = position
    map.addAnnotation(annotation)
    
  }

}

