//
//  MyChatViewController.swift
//  CafeNChat
//
//  Created by Yutong Zhang on 12/6/21.
//

import UIKit

class MyChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    var accepted : [Int] = []
    var accpLoc : [String] = []
    var firstTimeOpen = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accepted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "myCell")
        
        let image = UIImageView()
        image.image = DataModel.pictures[accepted[indexPath.row]]
        image.frame = CGRect(x: 40, y: 20, width: 80, height: 80)
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.black.cgColor
        cell.contentView.addSubview(image)
        
        let text = UILabel()
        text.text = "\(accpLoc[indexPath.row])"
        text.numberOfLines = 0
        text.frame = CGRect(x: 130, y: 22, width: 210, height: 50)
        text.textAlignment = .center
        // text.font = .systemFont(ofSize: 18)
        text.font = UIFont(name: "BradleyHandITCTT-Bold", size: 18.0)
        cell.contentView.addSubview(text)
        
        let subText = UILabel()
        subText.text = "in \(DataModel.cells[accepted[indexPath.row]]) mins"
        subText.numberOfLines = 0
        subText.adjustsFontSizeToFitWidth = true
        subText.frame = CGRect(x: 130, y: 73, width: 210, height: 20)
        subText.textAlignment = .center
        // subText.backgroundColor = .black
        // subText.font = .systemFont(ofSize: 18)
        subText.font = UIFont(name: "BradleyHandITCTT-Bold", size: 18.0)
        cell.contentView.addSubview(subText)
        
        let bound = UILabel()
        bound.layer.borderColor = UIColor.black.cgColor
        bound.layer.borderWidth = 3
        bound.frame = CGRect(x: 20, y: 0, width: 330, height: 120)
        cell.contentView.addSubview(bound)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatDetailVC") as! ChatDetailViewController
        vc.id = accepted[indexPath.row]
        vc.loc = accpLoc[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialAccepted()
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
        self.myTable.layoutMargins = .init(top: 0.0, left: 20.0, bottom: 0.0, right: 50.0)
        self.myTable.separatorInset = myTable.layoutMargins
        self.myTable.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInitialAccepted()
        myTable.reloadData()
    }
    
    
    func loadInitialAccepted() {
        if (firstTimeOpen) {
            accepted = [1]
            let _ = DataModel.saveData(accepted)
            print("initial data (empty id list) saved")
            
            accpLoc = ["Starbucks @ Fitzptrick Center"]
            let _ = DataModel.saveLoc(accpLoc)
            print("initial data (empty location list) saved")
            
            firstTimeOpen = false
            return
        }
        if let accepted = DataModel.loadData() {
            self.accepted = accepted
        } else {
            let accepted : [Int] = []
            let _ = DataModel.saveData(accepted)
            print("initial data (empty id list) saved")
        }
        
        if let accpLoc = DataModel.loadLoc() {
            // self.accepted = accepted.sorted()
            self.accpLoc = accpLoc
        } else {
            let accepLoc : [String] = []
            let _ = DataModel.saveLoc(accepLoc)
            print("initial data (emoty accpted chats' locations) saved")
        }
        
        
    }
    
    func sortChats() {
        var chats : [(Int, String)] = []
        for i in 0..<accepted.count {
            chats.append((accepted[i], accpLoc[i]))
        }
        chats.sort(by: { (first: (key: Int, value: String), second: (key: Int, value: String)) -> Bool in
            return first.key > second.key})
        
        for i in 0..<chats.count {
            accepted[i] = chats[i].0
            accpLoc[i] = chats[i].1
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
