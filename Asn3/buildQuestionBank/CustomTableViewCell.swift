//
//  CustomTableViewCell.swift
//  Asn3
//
//  Created by Marina Carvalho on 2024-11-12.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var wrongAnswer1Label: UILabel!
    @IBOutlet weak var wrongAnswer2Label: UILabel!
    @IBOutlet weak var wrongAnswer3Label: UILabel!
    
    static let identifier = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        correctAnswerLabel.textColor = UIColor.green
        wrongAnswer1Label.textColor = UIColor.red
        wrongAnswer2Label.textColor = UIColor.red
        wrongAnswer3Label.textColor = UIColor.red
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
