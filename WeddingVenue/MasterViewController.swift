//  Created by hienng on 12/3/16.
//  Copyright © 2016 chasingkite. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  
  var collection = WeddingVenueCollection()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collection.loadTestData()

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        if let controller = (segue.destination as! UINavigationController).topViewController as? WeddingVenueViewController {
          controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
          controller.navigationItem.leftItemsSupplementBackButton = true
          let weddingVenue = collection[indexPath.row]
          controller.weddingVenue = weddingVenue
        }
      }
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return collection.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let weddingVenue = collection[indexPath.row]
    if let cell = cell as? WeddingVenueTableViewCell {
      cell.weddingVenue = weddingVenue
    } else {
      cell.textLabel?.text = weddingVenue.name
    }
    
    return cell
  }
}

