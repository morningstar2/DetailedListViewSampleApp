
import UIKit

class MultilineLabelThatWorks : UILabel {
  override func layoutSubviews() {
    super.layoutSubviews()
    preferredMaxLayoutWidth = bounds.width
    super.layoutSubviews()
  }
  
  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    var rect = layoutMargins.apply(bounds)
    rect = super.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
    return layoutMargins.inverse.apply(rect)
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: layoutMargins.apply(rect))
  }
}

extension UIEdgeInsets {
  var inverse : UIEdgeInsets {
    return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
  }
  func apply(_ rect: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(rect, self)
  }
}
