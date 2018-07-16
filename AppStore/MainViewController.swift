//
//  ViewController.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appEntrys: [Entry] = []                   //앱 정보 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App Store"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        requestData()
    }

    func requestData() {
        let urlPath = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
        guard let url = URL(string: urlPath) else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                let responseData = try JSONDecoder().decode(Response.self, from: data!)
                self.appEntrys = responseData.feed.entry
                (0..<self.appEntrys.count).forEach{ self.appEntrys[$0].rank = $0 + 1 }
                dump(self.appEntrys)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? AppDetailViewController {
            destinationController.appId = sender as? String
        }
        
        //destinationController.appData = sender as? AppDataModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appEntrys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let row = indexPath.row
        
        cell.appData = appEntrys[row]
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.performSegue(withIdentifier: "showAppDetail", sender: appEntrys[row].id)
    }
}

