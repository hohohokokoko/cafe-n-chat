//
//  chatViewController.swift
//  CafeNChat
//
//  Created by Yutong Zhang on 12/5/21.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var refreshControl=UIRefreshControl()
    
    @IBOutlet weak var back: UIButton!
    @IBAction func backAction(_ sender: Any) {
        // self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    var subTitle = ""
    var ids : [Int] = []
    var accepted : [Int] = []
    var accpLoc : [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "chatCell")
        
        let image = UIImageView()
        image.image = DataModel.pictures[ids[indexPath.row]]
        image.frame = CGRect(x: 20, y: 20, width: 80, height: 80)
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.black.cgColor
        cell.contentView.addSubview(image)
        
        let text = UILabel()
        text.text = "in \(DataModel.cells[ids[indexPath.row]]) mins"
        text.frame = CGRect(x: 130, y: 38, width: 210, height: 20)
        text.textAlignment = .center
        // text.font = .systemFont(ofSize: 18)
        text.font = UIFont(name: "BradleyHandITCTT-Bold", size: 18.0)
        cell.contentView.addSubview(text)
        
        let subText = UILabel()
        subText.text = "Topic: " + DataModel.subs[ids[indexPath.row]]
        subText.numberOfLines = 0
        subText.adjustsFontSizeToFitWidth = true
        subText.frame = CGRect(x: 130, y: 63, width: 210, height: 20)
        subText.textAlignment = .center
        // subText.backgroundColor = .black
        // subText.font = .systemFont(ofSize: 18)
        subText.font = UIFont(name: "BradleyHandITCTT-Bold", size: 18.0)
        cell.contentView.addSubview(subText)
        
        let bound = UILabel()
        bound.layer.borderColor = UIColor.black.cgColor
        bound.layer.borderWidth = 3
        bound.frame = CGRect(x: 0, y: 0, width: 370, height: 120)
        cell.contentView.addSubview(bound)
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // cell selected code here
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showInvitationVC") as! InvitationViewController
        vc.location = subTitle
        vc.id = ids[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.white
    }

    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var cafeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAccepted()
        
        self.chatTable.delegate = self
        self.chatTable.dataSource = self
        self.chatTable.layoutMargins = .init(top: 0.0, left: 20.0, bottom: 0.0, right: 50.0)
        self.chatTable.separatorInset = chatTable.layoutMargins
        self.chatTable.separatorStyle = .none
        // Do any additional setup after loading the view.
        cafeName.text = subTitle
        
        // navigation bar is clear (set in storyboard)
        // hide nagivation block
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        ids = DataModel.ids
        ids.shuffle()
        ids = Array(ids[0..<6])
        ids.sort()
        
        // pull and refresh
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull for new feeds...")
        chatTable.addSubview(refreshControl)
    }
    
    
    @objc func refreshData() {
        ids = DataModel.ids
        ids.shuffle()
        ids = Array(ids[0..<6])
        ids.sort()
        chatTable.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func loadAccepted() {
        if let accepted = DataModel.loadData() {
            // self.accepted = accepted.sorted()
            self.accepted = accepted.sorted()
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
            print("initial data (empty accpted chats' locations) saved")
        }
    }
    
    func updateAccepted(newAccepted: Int) {
        accepted.append(newAccepted)
        _ = DataModel.saveData(accepted)
        accpLoc.append(subTitle)
        _ = DataModel.saveLoc(accpLoc)
        loadAccepted()
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
