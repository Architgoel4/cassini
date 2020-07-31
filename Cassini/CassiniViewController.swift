//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Goel, Archit on 14/12/17.
//  Copyright © 2017 Goel, Archit. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {

    //MARK: - Navigation
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""]{
            if let imageVC = (segue.destination.contents as? ImageViewController){
                imageVC.imageUrl = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self{
            if let ivc = secondaryViewController.contents as? ImageViewController, ivc.imageUrl == nil{
                return true
            }
        }
        return false
    }
}

extension UIViewController{
    var contents: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        } else{
            return self
        }
    }
}
