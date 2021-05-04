//
//  myTableViewCell.swift
//  raywenderlich-sample-project
//
//  Created by Mohamed Hafez on 5/1/21.
//

import UIKit

class myTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptonLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(article: Article){
        titleLabel.text = article.attributes.name
        descriptonLabel.text = article.attributes.description
        articleImage.sd_setImage(with: URL(string: article.attributes.cardArtworkUrl), placeholderImage: UIImage(systemName: "gear"))
        accessoryType = .disclosureIndicator
        
    }
    
}
