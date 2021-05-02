//
//  DescriptonViewController.swift
//  raywenderlich-sample-project
//
//  Created by Mohamed Hafez on 5/1/21.
//

import UIKit
import SDWebImage

class DescriptonViewController: UIViewController {
    
    var imageUrl: String = ""
    var text: String = ""
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(systemName: "gear"))
        descriptionText.text = text
        descriptionText.sizeToFit()
        
    }
    


}
