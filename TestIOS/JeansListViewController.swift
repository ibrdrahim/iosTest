//
//  HatListViewController.swift
//  TestIOS
//
//  Created by Ibrahim Indosystem on 1/6/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper
import Kingfisher

class JeansListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var hatList: UICollectionView!
    var shopDatas = [Hat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hatList.showsVerticalScrollIndicator = false
        hatList.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "itemCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dc = segue.destination as! ItemDetailViewController
        dc.data = shopDatas[sender as! Int]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detail", sender: indexPath.item)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //APIHandler.cancelAllRequest()
        
        let ss = ShopService()
        ss.jeansList(){
            APIResp in
            
            if let datas = Mapper<Hat>().mapArray(JSONObject: APIResp.list?.arrayObject){
                self.shopDatas = datas
            }
            
            self.hatList.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shopDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.hatList.frame.width * 0.45, height: self.hatList.frame.height * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.title.text = shopDatas[indexPath.item].name ?? ""
        
        
        
        if shopDatas[indexPath.item].imageUrl != nil && shopDatas[indexPath.item].imageUrl != "" {
            
            let url = URL(string: shopDatas[indexPath.item].imageUrl!)
            cell.picture.kf.setImage(with: url, options: [.forceRefresh])
        }
        
        return cell
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
