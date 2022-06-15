//
//  ViewController.swift
//  AmazonBook
//
//  Created by Gorbyno S on 15/06/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
  
    var buku:[Books?] = []
           
    
    @IBOutlet weak var tableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
        
        tableList.delegate = self
        tableList.dataSource = self
    }

    
    func parse(){
        guard let path = Bundle.main.path(forResource: "AmazonBooks", ofType: "json")else{
            return
        }
        let url = URL(fileURLWithPath:path)
        
        do{
            let jsonData = try Data(contentsOf: url)
            buku = try JSONDecoder().decode([Books?].self,from:jsonData)
            print(buku)
            print("success")
        }catch{
            print("error \(error)")
        }
        
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.buku.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell",for: indexPath) as! ListTableViewCell
           
//               // set the text from the data model
               cell.lableTitle?.text = self.buku[indexPath.row]?.title
//               cell.lableAuthor?.text = self.buku[indexPath.row]?.authors ?? ""
               if let uri = self.buku[indexPath.row]?.thumbnailUrl{
                   Alamofire.request(uri).response { (response) in
                       cell.imageBook?.image = UIImage(data: response.data!, scale:1)
                    }
               }else{
                   cell.imageBook?.image = UIImage(named:"emptyImage")
               }
//
             

               return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 120.0;//Choose your custom row height
      }
      
       
    
    // method to run when table view cell is tapped
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          print("You tapped cell number \(indexPath.row).")
          
          performSegue(withIdentifier: "showDetail", sender: self)
          
      }
    
  
    
 override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {

     if let destination = segue.destination as? DetailController{
         destination.buku = buku[(tableList.indexPathForSelectedRow?.row)!]
     }
        
    }
      
  

}

