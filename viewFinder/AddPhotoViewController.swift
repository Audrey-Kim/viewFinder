//
//  AddPhotoViewController.swift
//  viewFinder
//
//  Created by Apple on 7/15/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var caption: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self //tells object to give any info back to this class

        // Do any additional setup after loading the view.
    }
    
    //uses camera
    @IBAction func takeSelfieTapped(_ sender: UIButton) {
        imagePicker.sourceType = .camera //go into imagePicker object and select camera source type
        present(imagePicker, animated: true, completion: nil) //stop showing me initial screen and show camera view
    }
    
    //accesses saved photos album
    @IBAction func savedPhotosAlbum(_ sender: UIButton) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker,animated: true, completion: nil)
    }
    
    //accesses photo library
    @IBAction func photoLibraryTapped(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
    }
    
    //displays selected photo
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage.image = selectedImage
        }
        imagePicker.dismiss(animated: true, completion: nil) //makes image picker slide away from the top
    }
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext { //get the core data context
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context) //creating instance of Photo Entity from Core Data, and telling it to use the Photos entity and that I want the context; storing all info in constant called photoToSave
            photoToSave.captionInput = caption.text // stores caption
            
            if let userImage = newImage.image { //unwrapping to make sure we have the image
                if let userImageData = userImage.pngData() { //converting user image data into format that computer can read
                    photoToSave.photo = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            navigationController?.popViewController(animated: true)
        }
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
