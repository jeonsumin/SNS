//
//  NotificationsViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
    

    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "알림"
//        tabBarItem.
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 0
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
      }
}
