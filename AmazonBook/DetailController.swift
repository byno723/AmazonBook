//
//  DetailController.swift
//  AmazonBook
//
//  Created by Gorbyno S on 15/06/22.
//

import Foundation
import UIKit

import Alamofire
class DetailController : UIViewController{
    
    
    var buku : Books?
    
    @IBOutlet weak var imageDetail: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uri = self.buku?.thumbnailUrl{
            Alamofire.request(uri).response { (response) in
                self.imageDetail.image = UIImage(data: response.data!, scale:1)
             }
        }else{
            imageDetail.image = UIImage(named:"emptyImage")
        }
        

        titleLable.text = buku?.title
     
    }
}
