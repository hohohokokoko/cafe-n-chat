//
//  ChatDetailViewController.swift
//  CafeNChat
//
//  Created by Yutong Zhang on 12/7/21.
//

import UIKit

class ChatDetailViewController: UIViewController {

    var id: Int = 0
    var loc: String = ""
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar.image = DataModel.pictures[id]
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.black.cgColor
        
        nameLabel.text = DataModel.names[id]
        tagLabel.text = DataModel.subs[id]
        locationLabel.text = loc
        
        // calculate the time to meet
        let time = DataModel.cells[id]
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
