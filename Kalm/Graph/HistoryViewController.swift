//
//  HistoryViewController.swift
//  Kalm
//
//  Created by Yosua Hoo on 24/10/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController{
    
    var sessions : [Session] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        DispatchQueue.global().async {
            self.sessions = CloudKitHelper().fetchStoryRecord()
            self.sessions = CloudKitHelper().sessions
            print(self.sessions)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(sessions)
        loadingAlert()
        tableView.reloadData()
    }
    func loadingAlert(){
        let loadingAlert = UIAlertController(title: "Loading", message: "your conntent is beenig loaded", preferredStyle: UIAlertController.Style.alert)
        loadingAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(loadingAlert,animated: true , completion: nil)
    }
}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryDetailTableViewCell
        
        let startDate = sessions[indexPath.row].startDate
        let endDate = sessions[indexPath.row].endDate
        
        let duration = DateInterval.init(start: startDate, end: endDate)
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .none
        dateFormater.dateStyle = .medium
        
        DispatchQueue.main.async {
            cell.durationLabel.text = DateIntervalFormatter().string(from: duration)
            cell.dateLabel.text = dateFormater.string(from: startDate)
        }
        
        
        dateFormater.timeStyle = .medium
        dateFormater.dateStyle = .none
        
        DispatchQueue.main.async {
            cell.dateLabel.text = dateFormater.string(from: startDate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(CloudKitHelper().sessions)
    }
    
    
}
