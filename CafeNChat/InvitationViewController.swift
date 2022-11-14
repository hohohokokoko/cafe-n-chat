//
//  invitationViewController.swift
//  CafeNChat
//
//  Created by Yutong Zhang on 12/5/21.
//

import UIKit

class InvitationViewController: UIViewController {
    
    var id : Int = 0
    
    var avatarImg: UIImage? = UIImage()
    var name: String = ""
    var tag: String = ""
    var location: String = ""
    var time: Int = 0
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var block: UIButton!
    @IBOutlet weak var alert: UIButton!
    @IBOutlet weak var alertOK: UIButton!
    @IBAction func alertAction(_ sender: Any) {
        let parentViewController = navigationController?.viewControllers.dropLast().last as! ChatViewController
        let toDelete: Int = parentViewController.ids.firstIndex(of: id)!
        parentViewController.ids.remove(at: toDelete)
        
        parentViewController.chatTable.reloadData()
        parentViewController.updateAccepted(newAccepted: id)
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
    }
    @IBAction func AcceptAction(_ sender: Any) {
        /*if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
         */
        /*
        let parentViewController = navigationController?.viewControllers.dropLast().last as! ChatViewController
        let toDelete: Int = parentViewController.ids.firstIndex(of: id)!
        parentViewController.ids.remove(at: toDelete)
        
        parentViewController.chatTable.reloadData()
        parentViewController.updateAccepted(newAccepted: id)
        _ = navigationController?.popViewController(animated: true)
         */
        alert.isHidden = false
        alertOK.isHidden = false
        block.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert.isHidden = true
        alertOK.isHidden = true
        block.isHidden = true
        
        avatarImg = DataModel.pictures[id]
        name = DataModel.names[id]
        tag = DataModel.subs[id]
        time = DataModel.cells[id]
        
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.black.cgColor
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        nickName.text = name
        avatar.image = avatarImg
        // Do any additional setup after loading the view.
        tagLabel.text = tag
        locationLabel.text = location
        locationLabel.numberOfLines = 0
        
        // calculate the time to meet
        let currentDateTime = Date()
        let calendar = Calendar.current
        let showDateTime = calendar.date(byAdding: .minute, value: time, to: currentDateTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd/HH:mm"
        let curr = dateFormatter.string(from: showDateTime!)
        timeLabel.text = curr
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
