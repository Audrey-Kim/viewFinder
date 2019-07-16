//
//  PhotoDetailViewController.swift
//  viewFinder
//
//  Created by Apple on 7/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var detailPhoto: UIImageView!
    
    //using optional type; "Photos" was used here bc it's entity name in Core Data
    var photo : Photos? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let realPhoto = photo { //make sure we have a photo
            title = realPhoto.captionInput //make the title on nav bar match title you gave photo
            
            if let cellPhotoImageData = realPhoto.photo { //gets image data, converts to right format, and makes that image view show photo that was tapped on
                if let cellPhotoImage = UIImage(data: cellPhotoImageData) {
                    detailPhoto.image = cellPhotoImage
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
