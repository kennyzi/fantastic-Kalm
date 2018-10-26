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
    let cloudKitHelper = CloudKitHelper()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        sessions = cloudKitHelper.sessions
        print(sessions)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
//        DispatchQueue.global().async {
//            self.sessions = self.cloudKitHelper.fetchStoryRecord()
//            self.sessions = self.cloudKitHelper.sessions
//            print(self.sessions)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        
        DispatchQueue.global().sync {
            cloudKitHelper.fetchStoryRecord(handler: { (sessions) in
                self.sessions = sessions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        print(sessions)
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
<<<<<<< HEAD
        print(sessions)
        loadingAlert()
        tableView.reloadData()
=======
       
>>>>>>> 0fa16681b56951e1311e35a48fa03106c781e480
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
        
        
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .none
        dateFormater.dateStyle = .medium
        
//        let duration = DateInterval.init(start: startDate, end: endDate)
//        let dateIntervalFormater = DateIntervalFormatter()
//        dateIntervalFormater.timeStyle = .short
        
        print(startDate)
        print(endDate)
        
        let duration = endDate.timeIntervalSince(startDate)
        var seconds = 0
        var minutes = 0
        
            if duration > 59 {
                minutes = Int(duration / 60)
                seconds = Int(duration) - (60 * minutes)
            } else {
                minutes = 0
                seconds = Int(duration)
            }
        
        DispatchQueue.main.async {
            if minutes < 10 {
                if seconds < 10 {
                    cell.durationLabel.text = "0\(minutes) : 0\(seconds)"
                } else {
                    cell.durationLabel.text = "0\(minutes) : \(seconds)"
                }
            } else {
                if seconds < 10 {
                    cell.durationLabel.text = "\(minutes) : 0\(seconds)"
                } else {
                    cell.durationLabel.text = "\(minutes) : \(seconds)"
                }
            }
        }
        
        DispatchQueue.main.async {
            cell.dateLabel.text = dateFormater.string(from: startDate)
        }
        
        let timeFormater = DateFormatter()
        timeFormater.timeStyle = .short
        timeFormater.dateStyle = .none
        
        DispatchQueue.main.async {
            cell.timeLabel.text = timeFormater.string(from: startDate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(CloudKitHelper().sessions)
    }
    
    
}
