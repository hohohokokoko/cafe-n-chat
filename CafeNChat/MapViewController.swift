//
//  MapViewController.swift
//  CafeNChat
//
//  Created by Yutong Zhang on 12/5/21.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: UIImageView!
    @IBOutlet weak var boyu: UIButton!
    @IBOutlet weak var starbaba: UIButton!
    @IBOutlet weak var perkins: UIButton!
    @IBAction func starbabaAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showChatVC") as! ChatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.subTitle = "Starbucks @ Fitzptrick Center"
        self.show(vc, sender: self)
        // self.present(vc, animated:true, completion:nil)
    }
    @IBAction func perkinsAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showChatVC") as! ChatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.subTitle = "Saladelia @ The Perk"
        self.show(vc, sender: self)
    }
    @IBAction func boyuAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showChatVC") as! ChatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.subTitle = "Beyu Blue @ Bryan Center"
        self.show(vc, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // map.layer.cornerRadius = (self.frame.size.width / 2.0)
        map.clipsToBounds = true
        map.layer.masksToBounds = true
        
        map.layer.borderColor = UIColor.black.cgColor
        map.layer.borderWidth = 3
    
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
