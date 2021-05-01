//
//  ViewController.swift
//  raywenderlich-sample-project
//
//  Created by Mohamed Hafez on 4/29/21.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var articlesJson: JSON?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
        articlesJson = loadData(fileName: "articles")
//        loadData(fileName: "videos")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articlesWrapped = articlesJson {
            return articlesWrapped["data"].count
        }
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
        if let articlesJsonWrapped = articlesJson {
            let title = articlesJsonWrapped["data"][indexPath.row]["attributes"]["name"]
            let description = articlesJsonWrapped["data"][indexPath.row]["attributes"]["description"]
            let imageUrl = articlesJsonWrapped["data"][indexPath.row]["attributes"]["card_artwork_url"].stringValue
            
            cell.textLabel?.text = title.stringValue
            cell.detailTextLabel?.text = description.stringValue
//            cell.imageView?.image = UIImage(systemName: "gear")
            cell.imageView?.sd_setImage(with: URL(string: imageUrl),placeholderImage: UIImage(systemName: "gear"))
            
        }
        
//        cell.imageView?.backgroundColor = .green
//        print(cell.imageView?.image )
        return cell
    }
    
    
    func loadData(fileName: String) -> JSON? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                print("json data \(jsonObj)")
                return jsonObj
//                print("experiment")
//                print(jsonObj["data"][0]["attributes"]["description"])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

