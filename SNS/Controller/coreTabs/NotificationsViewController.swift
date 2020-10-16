//
 //  NotificationsViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

enum UserNotificationType {
    case like(post:UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let User: User
}

final class NotificationsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
    

    private let tableView: UITableView = {
       let table = UITableView()
        table.isHidden = false
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
    
    private var models = [UserNotification]()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "알림"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
//        spinner.startAnimating()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func fetchNotifications(){
        for x in 0...100{
            let user = User(username: "안우진",
                            bio: "",
                            name: "",
                            profilePhoto: URL(string: "https://google.com")!,
                            birthDate: Date(),
                            gender: .male,
                            counts: UserCount(followers: 1,
                                              following: 1,
                                              posts: 1),
                            joinDate: Date())
            
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCount: [],
                                commonts: [],
                                createDate: Date(),
                                taggeduser: [],
                                owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hellow World",
                                         User: User(username: "안우진",
                                                    bio: "",
                                                    name: "",
                                                    profilePhoto: URL(string: "https://google.com")!,
                                                    birthDate: Date(),
                                                    gender: .male,
                                                    counts: UserCount(followers: 1,
                                                                      following: 1,
                                                                      posts: 1),
                                                    joinDate: Date()))
            models.append(model)
        }
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
        return models.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type{
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier ,
                                                     for: indexPath) as! NotificationLikeEventTableViewCell
            
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier ,
                                                     for: indexPath) as! NotificationFollowEventTableViewCell
//            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            // open the post
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .follow(_):
            fatalError("개발자 문제는 절대 호출되지 않습니다.")
        }
        
        
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate{
    func didTapFoloowUnFollowButton(model: UserNotification) {
        print("tapped button")
        //perform database update
        
    }
    
    
}
