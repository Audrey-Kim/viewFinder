//
//  PhotoTableViewController.swift
//  viewFinder
//
//  Created by Apple on 7/15/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {

    var photos : [Photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        }
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    // MARK: - Table view data source

    func getPhotos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext { //get into core data
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] { //fetch() retrieves data from Core data
                photos = coreDataPhotos
                    tableView.reloadData()
            }
        }
    }
    
    //calling getPhotos()
    override func viewWillAppear(_ animated: Bool) {
        getPhotos()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell is referring to each row in the table; we stored an instance of UITableViewCell so it has all the attributes
        let cell = UITableViewCell()
        
        //accesses current photo we're looking at
        let cellPhoto = photos[indexPath.row]
        cell.textLabel?.text = cellPhoto.captionInput
        
        if let cellPhotoImageData = cellPhoto.photo {
            if let cellPhotoImage = UIImage(data: cellPhotoImageData) {
                cell.imageView?.image = cellPhotoImage
            }
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: photos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" { //know if we're dealing with the correct segue
            if let photoDetailView = segue.destination as? PhotoDetailViewController { //get into the PhotoDetailViewController
                if let photoToSend = sender as? Photos { //take photo that was tapped on and send to PhotoDetailViewController
                    photoDetailView.photo = photoToSend
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext { //get the context, since we want to delete this from Core Data
                let photoToDelete = photos[indexPath.row] //select row that was swiped
                context.delete(photoToDelete) //deletes record of photo and its caption from Core Data database
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getPhotos()
            }
        }
    }
    
}
