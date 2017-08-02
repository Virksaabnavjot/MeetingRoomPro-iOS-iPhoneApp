//
//  PhotoGalleryViewController.swift
//  MRPro
//  Purpose: Handles photo gallery operations
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import SDWebImage

/*
 Photo gallery for room
 */
class PhotoGalleryViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    //creating image view
    @IBOutlet weak var mainImgVu: UIImageView!
    var meetingRoom: MeetingRoom!
    
    //image view collecion
    @IBOutlet weak var collectionVu: UICollectionView!
    var arrayOfPhotos = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo gallery"
        
        var dictRequest: [String : Any] = [:]
        
        //getting room id
        dictRequest["roomID"] = meetingRoom.id
        
        //making request to the api and getting photos for the rooms by its id
        API.sharedInstance.getRoomImages(dictRequest) { (success, dictData) -> Void in
            
            //if status code == true, proceed with request
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                //get array of photos
                self.arrayOfPhotos = userData["data"] as! Array
                
                //reload the collection view
                self.collectionVu.reloadData()
                
                if (self.arrayOfPhotos.count > 0)
                {
                    self.mainImgVu.sd_setImage(with: URL(string: "https://mrpro.000webhostapp.com/MRProApp/MRPro/MRPro/" + self.arrayOfPhotos[0]["url"]!), placeholderImage: UIImage(named: "placeholder"))
                }
                
            }else{
                
                self.displayAlert(dictData["code"] as! String!)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //add styling to colection view
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.size.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    //return photos count
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return arrayOfPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //collection cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! ImageCollectionCell
        cell.imgVu.backgroundColor = UIColor.black
        
        //set immages
        cell.imgVu.sd_setImage(with: URL(string: "https://mrpro.000webhostapp.com/MRProApp/MRPro/MRPro/" + arrayOfPhotos[indexPath.row]["url"]!), placeholderImage: UIImage(named: "placeholder"))
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.mainImgVu.sd_setImage(with: URL(string: "https://mrpro.000webhostapp.com/MRProApp/MRPro/MRPro/" + arrayOfPhotos[indexPath.row]["url"]!), placeholderImage: UIImage(named: "placeholder"))
        
    }

    //helps display alert
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
