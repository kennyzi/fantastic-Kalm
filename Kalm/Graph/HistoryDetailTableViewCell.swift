//
//  HistoryDetailTableViewCell.swift
//  Charts
//
//  Created by Yosua Hoo on 24/10/18.
//

import UIKit

@available(iOS 9.0, *)
class HistoryDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    var largeTextConstraints : [NSLayoutConstraint] = []
    var regularConstraints : [NSLayoutConstraint] = []
    
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 11.0, *) {
            let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
            if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory{
                updateStackView()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func updateStackView(){
        if #available(iOS 11.0, *) {
            if traitCollection.preferredContentSizeCategory.isAccessibilityCategory{
                stackView.axis = UILayoutConstraintAxis.vertical
                durationLabel.textAlignment = NSTextAlignment.left
                timeLabel.textAlignment = NSTextAlignment.left
                dateLabel.textAlignment = NSTextAlignment.left
                stackView.spacing = 3
            }else{
                stackView.axis = UILayoutConstraintAxis.horizontal
                durationLabel.textAlignment = NSTextAlignment.left
                timeLabel.textAlignment = NSTextAlignment.center
                dateLabel.textAlignment = NSTextAlignment.right
                stackView.spacing = 0
            }
        } else {
            // Fallback on earlier versions
        }
    }

}
