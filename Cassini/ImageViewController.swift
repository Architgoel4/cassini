//
//  ImageViewController.swift
//  Cassini
//
//  Created by Goel, Archit on 13/12/17.
//  Copyright © 2017 Goel, Archit. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
//, UIScrollViewDelegate
{
    //MODEL
    
    var imageUrl : URL? {
        didSet{
             image = nil
            if view.window != nil{
                fetchURL()
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //PRIVATE IMPLEMENTATION
    
    private func fetchURL(){
        //this next line of code can throw an error
        // and it also will block the UI entirely while it accesses the network
        //we really should be doing it in a separate thread
        spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = self?.imageUrl, let imageData = try? Data(contentsOf: url), url == self?.imageUrl{
                DispatchQueue.main.async {
                    self?.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    //View Controller lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil{
            fetchURL()
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //view.addSubview(imageView)
//        imageUrl = DemoURL.stanford
//    }
    
    // User Interface
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            //to add zoom delegate
            //but we need to use the UIScrollViewDelegate protocol
            //else extension below to handle
            scrollView.delegate = self
        
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 2.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    //private to everyone in the file
    fileprivate var imageView =  UIImageView()
    
    private var image: UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}


extension ImageViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
