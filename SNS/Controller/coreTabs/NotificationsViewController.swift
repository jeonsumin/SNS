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
        table.isHidden = true
        table.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
      table.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
          
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationView = NotificationView()
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "알림"
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(spinner)
        spinner.startAnimating()
        view.addSubview(tableView)
        view.addSubview(noNotificationView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100)
        spinner.center = view.center
    }
    
    private func addlayoutNoNotification(){
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(
                x: 0,
                y: 0,
                width: view.width/2,
                height: view.width/4)
            noNotificationView.center = view.center
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 0
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
      }
}
