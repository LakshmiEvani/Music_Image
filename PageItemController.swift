//
//  PageItemController.swift
//  Music_Image
//
//  Created by Souji on 1/31/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }

    
    @IBOutlet var contentImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        contentImageView!.image = UIImage(named: imageName)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
