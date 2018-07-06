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
    
    var appEntrys: [Response.Feed.Entry] = []                   //앱 정보 배열
    
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
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            do {
                //let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                let responseData = try JSONDecoder().decode(Response.self, from: data!)
                
                self.appEntrys = responseData.feed.entry
                
                dump(self.appEntrys)
                
//                let json = JSON(jsonResult)
//                let appInfos = json["feed"]["entry"].arrayValue
                
                //앱 정보 저장
//                for appInfo in appInfos {
//                    let appData = AppDataModel(json: appInfo)
//                    self.appDatas.append(appData)
//                }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        })
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController = segue.destination as? AppDetailViewController else { return }
        
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
        
        //cell.appData = appDatas[row]
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        //appDatas[row].rank = row + 1
        //self.performSegue(withIdentifier: "showAppDetail", sender: appDatas[row].appID)
    }
}

