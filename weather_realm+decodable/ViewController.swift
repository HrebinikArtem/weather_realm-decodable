//
//  ViewController.swift
//  weather_realm+decodable
//
//  Created by Artem Grebinik on 10/11/18.
//  Copyright © 2018 Artem Hrebinik. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
       let tb = UITableView(frame: self.view.bounds)
        tb.delegate = self
        tb.dataSource = self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tb
    }()
    
    
    let service = WeatherService()
    var items:Results<Wel>!

        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(tableView)
        addSourceData() 
        
        grabData()
    }
    
    private func grabData() {
        let realm = RealmService.shared.realm
        items = realm.objects(Wel.self)
        self.tableView.reloadData()
    }
    
    private func addSourceData() {
        let realmService = RealmService.shared
        
        service.getWeatherForecast(for: "Kharkiv") { (weatherObject) in
            realmService.create(weatherObject)
        }
    }
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].timezone
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realmService = RealmService.shared
        
        realmService.delete(items[indexPath.row])
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
