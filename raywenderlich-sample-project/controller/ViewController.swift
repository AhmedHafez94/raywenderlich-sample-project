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
    var rowSelected: Int?
    var articlesJson: JSON?
    var homeDescription: String = ""
    var homeUrl: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myTableViewCell
        if let articlesJsonWrapped = articlesJson {
            let title = articlesJsonWrapped["data"][indexPath.row]["attributes"]["name"].stringValue
            let description = articlesJsonWrapped["data"][indexPath.row]["attributes"]["description"].stringValue
            let imageUrl = articlesJsonWrapped["data"][indexPath.row]["attributes"]["card_artwork_url"].stringValue
            homeUrl = imageUrl
            homeDescription = description
//            cell.textLabel?.text = title.stringValue
//            cell.detailTextLabel?.text = description.stringValue
//            cell.imageView?.image = UIImage(systemName: "gear")
//            cell.imageView?.sd_setImage(with: URL(string: imageUrl),placeholderImage: UIImage(systemName: "gear"))
            
            cell.titleLabel.text = title
            cell.descriptonLabel.text = description
            cell.articleImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(systemName: "gear"))
            cell.accessoryType = .disclosureIndicator
            
            
            
        }
        
//        cell.imageView?.backgroundColor = .green
//        print(cell.imageView?.image )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        performSegue(withIdentifier: "goToDescription", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDescription" {
            let destinationVC = segue.destination as? DescriptonViewController
            let jsonAttr = jsonAttributes(json: articlesJson, row: rowSelected ?? 0)
            destinationVC?.text = jsonAttr.1
            destinationVC?.imageUrl = jsonAttr.2
        }
    }
    func jsonAttributes(json: JSON?, row: Int) -> (String,String,String) {
        if let jsonWrapped = json {
            let title = jsonWrapped["data"][row]["attributes"]["name"].stringValue
            let description = jsonWrapped["data"][row]["attributes"]["description"].stringValue
            let imageUrl = jsonWrapped["data"][row]["attributes"]["card_artwork_url"].stringValue
            return (title, description,imageUrl)
        }
        
        
        return ("title", "description","imageUrl")
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

