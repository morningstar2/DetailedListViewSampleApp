
import UIKit

class WeddingVenueTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var weddingImage : UIImageView!
  @IBOutlet weak var ratingImage: UIImageView!

  
  var weddingVenue : WeddingVenue? {
    didSet {
      if let weddingVenue = weddingVenue {
        nameLabel?.text = weddingVenue.name
        weddingImage?.image = weddingVenue.thumbnail ?? UIImage(named: "placeholder_thumb")
        ratingImage?.image = weddingVenue.rating.smallRatingImage
      }
    }
  }
}
