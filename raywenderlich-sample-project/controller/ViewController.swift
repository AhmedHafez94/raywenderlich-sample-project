//
//  ViewController.swift
//  raywenderlich-sample-project
//
//  Created by Mohamed Hafez on 4/29/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var articles: [Article] = []
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        title = "Raywenderlich.com"
        activityIndicator.hidesWhenStopped = true


        fetchData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myTableViewCell
        cell.configure(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDescription", sender: articles[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDescription" {
            let destinationVC = segue.destination as? DescriptonViewController
            let selectedArticle = sender as! Article
            destinationVC?.text = selectedArticle.attributes.description
            destinationVC?.imageUrl = selectedArticle.attributes.cardArtworkUrl
        }
    }
   
    
    
    
    //                https://api.github.com/repos/raywenderlich/ios-interview/contents/Practical%20Example/articles.json
    
    
    func fetchData()  {
        let request = AF.request("https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/articles.json")
        //show loading indicator
        activityIndicator.startAnimating()
        
        request.responseJSON { (response) in
            //hide loading indicator
            self.activityIndicator.stopAnimating()
           
            print(response)
            guard response.error == nil else {
                // handle error
                return
            }
            // validate response and save to articles
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let page = try! decoder.decode(Page.self, from: response.data!)
            self.articles =  page.data
            self.tableView.reloadData()
        }
        
    }
    
    
}

