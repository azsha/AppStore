//
//  ViewController.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appDatas: [AppDataModel] = []                       //앱 정보 배열
    
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
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                let json = JSON(jsonResult)
                let appInfos = json["feed"]["entry"].arrayValue
                
                //앱 정보 저장
                for appInfo in appInfos {
                    let appData = AppDataModel(json: appInfo)
                    self.appDatas.append(appData)
                }
            
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
        
        destinationController.appData = sender as? AppDataModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let row = indexPath.row
        
        cell.titleLabel.text = appDatas[row].title
        cell.categoryLabel.text = appDatas[row].category
        
        if let iconIamge = appDatas[row].iconImage {
            cell.appIconImageView.image = iconIamge
        } else {
            cell.appIconImageView.image = nil
            
            //이미지가 없는 경우 서버로부터 다운로드
            DispatchQueue.global().async {
                self.appDatas[row].downloadIconImage()
                DispatchQueue.main.async {
                    cell.appIconImageView.image = self.appDatas[row].iconImage
                }
            }
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        self.performSegue(withIdentifier: "showAppDetail", sender: appDatas[row])
    }
}

