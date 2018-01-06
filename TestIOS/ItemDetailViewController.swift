//
//  ItemDetailViewController.swift
//  
//
//  Created by Ibrahim Indosystem on 1/6/18.
//

import UIKit
import Kingfisher

class ItemDetailViewController: UIViewController {
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var pricce: UILabel!
    @IBOutlet var brand: UILabel!
    
    @IBOutlet var desc: UITextView!
    
    var data : Hat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = data?.name ?? ""
        self.pricce.text = data?.price ?? ""
        self.brand.text = data?.brand ?? ""
        self.desc.text = data?.description ?? ""
        
        if data?.imageUrl != nil && data?.imageUrl != "" {
            let url = URL(string: data!.imageUrl!)
            self.picture.kf.setImage(with: url, options: [.forceRefresh])
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func close_tap(sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
