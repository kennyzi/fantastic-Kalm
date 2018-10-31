//
//  HistoryDetailTableViewCell.swift
//  Charts
//
//  Created by Yosua Hoo on 24/10/18.
//

import UIKit

class HistoryDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        durationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        timeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        if #available(iOS 10.0, *) {
            durationLabel.adjustsFontForContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            timeLabel.adjustsFontForContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            dateLabel.adjustsFontForContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
