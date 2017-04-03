//  Created by hienng on 12/3/16.
//  Copyright © 2016 chasingkite. All rights reserved.
//

import Foundation

class WeddingVenueCollection {
  fileprivate var _weddingVenues = [WeddingVenue]()
  fileprivate var _favorite: WeddingVenue?

  /** Get the number of pancake houses in the collection */
  var count: Int {
    return _weddingVenues.count
  }

  /** Subscript access */
  subscript(index: Int) -> WeddingVenue {
    return _weddingVenues[index]
  }

  /** Loads test data from the bundled plist. Replaces the contents of the collection with the test data. */
  func loadTestData() {
    if let testWeddingVenues = WeddingVenue.loadDefaultWeddingVenues() {
      _weddingVenues = testWeddingVenues
    }
  }

  /** Read-only property on whether the collection is synced to the cloud or not. App must be running with a user logged in for this to be true. */
  var isCloudCollection: Bool {
    return false
  }

  /** Loads test data from the cloud if this is a cloud-enabled collection.

  This method returns immediately and calls the completion handler when finished, with a Boolean parameter on whether data was loaded or not.

  Replaces the contents of the collection with the test data on success. */
  func loadCloudTestData(_ completion: ((Bool) -> ())?) {
    let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
      guard self.isCloudCollection else {
        completion?(false)
        return
      }

      if let testWeddingVenues = WeddingVenue.loadDefaultWeddingVenues() {
        self._weddingVenues = testWeddingVenues
        completion?(true)
      }
    }
  }

  /** Stores the current favorite pancake house. The one you set _must_ already be in the collection. */
  var favorite: WeddingVenue? {
    get {
      return _favorite
    }
    set {
      if let newValue = newValue {
        if _weddingVenues.contains(newValue) {
          _favorite = newValue
        }
      } else {
        _favorite = nil
      }
    }
  }

  /** Checks if the passed-in pancake house is the favorite */
  func isFavorite(_ weddingVenue: WeddingVenue) -> Bool {
    guard let currentFavorite = favorite else {
      return false
    }

    return currentFavorite == weddingVenue
  }

  /** Add a new pancake house to the collection. */
  func addWeddingVenue(_ weddingVenue: WeddingVenue) {
    _weddingVenues.append(weddingVenue)
  }

  /** Remove a pancake house from the collection. If it's the current favorite, doesn't remove it. */
  func removeWeddingVenue(_ weddingVenue: WeddingVenue) {
    if let index = _weddingVenues.index(of: weddingVenue), !isFavorite(weddingVenue) {
      _weddingVenues.remove(at: index)
    }
  }

}
