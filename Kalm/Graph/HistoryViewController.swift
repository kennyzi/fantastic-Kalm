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
    
    let loadingAlert = UIAlertController(title: "Loading", message: "your conntent is beenig loaded", preferredStyle: UIAlertController.Style.alert)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    
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
         let screenSize: CGRect = UIScreen.main.bounds
        let myView = SpinnerView(frame: CGRect(x: screenSize.width/2, y: screenSize.height/2, width: 100, height: 100))
        self.loadingView.addSubview(myView)
        tableView.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: 0)
        
        self.navigationItem.title = "Session History"
        self.navigationController?.navigationBar.backItem?.accessibilityLabel = "Back"
        // fetch data
        fetchStoryFromCloudKit()
        
        print(sessions)
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(sessions)
//        present(loadingAlert,animated: true , completion: nil)
        tableView.reloadData()
    }
    func fetchStoryFromCloudKit(){
        NotificationCenter.default.addObserver(self, selector: #selector(HistoryViewController.networkStatusChange(_:)), name: NSNotification.Name(ReachabilityStatusChangedNotification), object: nil)
        NetworkHelper().monitorReachabilityChanges()
    }
    @objc func networkStatusChange(_ notifation: NSNotification){
        let status = NetworkHelper().connectionStatus()
        print(status)
        
        switch status {
        case .offline:
            let offlineAlert = UIAlertController(title: "Warning", message: "you don't heve internet connection", preferredStyle: UIAlertController.Style.alert)
            offlineAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(offlineAlert, animated: true, completion: nil)
        case .online(.wwan), .unknown:
            let unstableAlert = UIAlertController(title: "Warning", message: "you don't heve stable internet connection", preferredStyle: UIAlertController.Style.alert)
            unstableAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (progress) in
                DispatchQueue.global().sync {
                    self.fetchData()
                }
            }))
            self.present(unstableAlert, animated: true, completion: nil)
        case .online(.wiFi):
            DispatchQueue.global().sync {
                self.fetchData()
                
            }
        }
    }
    func fetchData(){
            cloudKitHelper.fetchStoryRecord(handler: { (sessions) in
                self.sessions = sessions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
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
        
        if minutes != 0{
            cell.durationLabel.accessibilityLabel = "\(minutes) minutes, \(seconds) seconds duration"
        }else{
            cell.durationLabel.accessibilityLabel = "\(seconds) seconds duration"
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
        
        cell.timeLabel.accessibilityLabel = "on \(timeFormater.string(from: startDate))"
        
//        loadingAlert.dismiss(animated: true, completion: nil)
        loadingView.isHidden = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(CloudKitHelper().sessions)
    }
    
    
}
