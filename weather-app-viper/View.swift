//
//  View.swift
//  weather-app-viper
//
//  Created by Sena Uzun on 26.11.2022.
//

import Foundation
import UIKit

protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    func update(with pharms : [Wheather])
    func update(with error : String)
    
}

class WeatherViewController : UIViewController , AnyView , UITableViewDelegate,UITableViewDataSource  {
 
    var presenter : AnyPresenter?
    var weathers : [Wheather] = []
    
    
    private let tableView : UITableView = {
        
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label  = UILabel()
        label.isHidden = false
        label.text = "Dowloading..."
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = . center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 50, width: 200, height: 50)
    }
    
    
    func update(with weathers : [Wheather]) {
        DispatchQueue.main.async {
            self.weathers = weathers
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden=false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.weathers = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        
        content.text  = weathers[indexPath.row].address
        content.secondaryText = weathers[indexPath.row].description
        cell.contentConfiguration = content
        cell.backgroundColor = .lightGray
        
        return cell
    }
}
