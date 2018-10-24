//
//  InfoViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 06/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "BackBtn"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn.addTarget(self, action: #selector(InfoViewController.backButtonPressed), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        let item = UIBarButtonItem(customView: btn)

        let infoTitle = UILabel()
        infoTitle.text = "FAQ"
        let fontname = "Roboto-Bold"
        infoTitle.font = UIFont(name: "\(fontname)", size: 17)
        infoTitle.textColor = UIColor.init(red: 248/255, green: 162/255, blue: 118/255, alpha: 1)
        
        
        let stackView = UIStackView(arrangedSubviews: [infoTitle])
        stackView.axis = .horizontal
        stackView.frame.size.width = infoTitle.frame.width
        stackView.frame.size.height = infoTitle.frame.height
        
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        self.navigationItem.titleView = infoTitle
       
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
    }
    
    var sections = [
        Section(question: "What is deep breathing exercise?", detail: ["Deep breathing exercises can help you relax, because they make your body feel like it does when you are already relaxed. \n\nDeep breathing is one of the best ways to lower stress in the body. This is because when you breathe deeply, it sends a message to your brain to calm down and relax."], expanded: false),
        Section(question: "What is HRV (Heart Rate Variability)?", detail: ["Heart Rate Variability is a measure which indicates how much variation there is in your heartbeats within a specific timeframe. The unit of measurement is milliseconds (ms).\n\n *   If the intervals between your heartbeats are rather constant, your HRV is low.\n *   If their length variates, your HRV is high."], expanded: false),
        Section(question: "What is the standard of HRV?", detail: ["A healthy heart beat contains healthy irregularities. High heart rate variability is an indication of especially cardiovascular, but also overall health as well as general fitness, and vice versa. \n\nHowever, you shouldn’t compare your heart rate variability with other people, because HRV is affected by a number of internal and external factors, such as age, hormones and the overall body functions, as well as lifestyle."], expanded: false)
        
    ]
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return sections[numberOfRowsInSection].detail.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection: Int) -> CGFloat{
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        if(sections[heightForRowAt.section].expanded){
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
            return tableView.rowHeight
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[viewForHeaderInSection].question, section: viewForHeaderInSection, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[cellForRowAt.section].detail[cellForRowAt.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int){
        sections[section].expanded = !sections[section].expanded
        
        for i in 0 ..< sections[section].detail.count{
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        
        tableView.endUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
