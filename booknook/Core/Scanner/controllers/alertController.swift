//
//  alertController.swift
//  booknook
//
//  Created by Caleb Long on 8/22/23.
//

import Foundation
import UIKit
  
  
class alertController {
  
    func showAlert(fromController controller: UIViewController) {
        var alert = UIAlertController(title: "abc", message: "def", preferredStyle: .alert)
        controller.present(alert, animated: true, completion: nil)
        }
  
  
}
