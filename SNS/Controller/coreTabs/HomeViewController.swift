//
//  ViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//
import Firebase
import UIKit



struct HomeFeedRnderViewModel {
    let header : PostRenderViewModel
    let post : PostRenderViewModel
    let actions:PostRenderViewModel
    let comments:PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRanderModels = [HomeFeedRnderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        // 셀 등록
        table.register(IGFeedPostTableViewCell.self,
                       forCellReuseIdentifier:IGFeedPostTableViewCell.identifier)
        table.register(IGFeedPostHeaderTableViewCell.self,
                       forCellReuseIdentifier:IGFeedPostHeaderTableViewCell.identifier)
        table.register(IGFeedPostActionsTableViewCell.self,
                       forCellReuseIdentifier:IGFeedPostActionsTableViewCell.identifier)
        table.register(IGFeedPostGeneralTableViewCell.self,
                       forCellReuseIdentifier:IGFeedPostGeneralTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModls()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    private func createMockModls(){
        let user = User(username: "안우진",
                        bio: "",
                        name: "",
                        profilePhoto: URL(string: "htts://www.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        counts: UserCount(followers: 1,
                                          following: 1,
                                          posts: 1),
                        joinDate: Date())
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            commonts: [],
                            createDate: Date(),
                            taggeduser: [],
                            owner: user)
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@안우진",
                                        text: "잘보고가요~",
                                        createDate: Date(),
                                        likes: []))
        }
        for x in 0..<5{
            let viewModel = HomeFeedRnderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                   post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                   actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                   comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRanderModels.append(viewModel)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handlNotAuthenticated()
    }
    
    private func handlNotAuthenticated(){
        
        //인증 체크하기
        if Auth.auth().currentUser == nil {
            // loginView 보여주기
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRanderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model : HomeFeedRnderViewModel
        
        if x == 0 {
            model = feedRanderModels[0]
            
        }else{
            let position = x % 4 == 0 ? x/4 : (x - (x%4)/4)
            model = feedRanderModels[position]
        }
        let subSection = x % 4
        if subSection == 0 {
            //header
            return 1
        }else if subSection == 1 {
            // post
            return 1
        }else if subSection == 2 {
            //actions
            return 1
        }else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
               return comments.count > 2 ? 2 : comments.count
            case .header,.actions,.primaryContent: return 0
                
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model : HomeFeedRnderViewModel
        
        if x == 0 {
            model = feedRanderModels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : (x - (x%4)/4)
            model = feedRanderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //header
            switch model.header.renderType {
            case .header(let user) :
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments,.actions,.primaryContent: return UITableViewCell()
            }
        }else if subSection == 1 {
            // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                
                return cell
            case .header,.actions,.comments: return UITableViewCell()
            }
        }else if subSection == 2 {
            //actions
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .header,.comments,.primaryContent: return UITableViewCell()
            }
        }else if subSection == 3 {
            // comments
            
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header,.actions,.primaryContent:return UITableViewCell()
            }
        }
     return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //cell 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            //header
            return 70
        }else if subSection == 1 {
            //post
            return tableView.width
        }else if subSection == 2 {
            //action
            return 60
        }else if subSection == 3 {
            //Comments row
            return 50
        }
            return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoerButton() {
        let actionsheet = UIAlertController(title: "옵션", message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "신고하기", style: .destructive , handler: {[weak self] _ in
            self?.reportPost()
        }))
        actionsheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(actionsheet,animated: true)
    }
    func reportPost() {
        
    }
    
    
}
extension HomeViewController:IGFeedPostActionsTableViewCellDelegate{
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapcommentButton() {
        print("like")
    }
    
    func didTapSendButton() {
        print("like")
    }
    
    
}
