//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 31/07/2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel:UILabel!
    @IBOutlet weak var currencyValueLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
