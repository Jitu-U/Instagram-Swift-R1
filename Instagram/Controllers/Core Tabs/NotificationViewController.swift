//
//  NotificationViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import UIKit

enum UserNotification{
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct userNotification {
    let type: UserNotification
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationsFollowerTableViewCell.self,
                           forCellReuseIdentifier: NotificationsFollowerTableViewCell.identifier)
        tableView.register(NotificationsLikeTableViewCell.self,
                           forCellReuseIdentifier: NotificationsLikeTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()

    private var models = [userNotification]()
    
    //MARK: - Lifecycle
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        //spinner.startAnimating()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        spinner.center = view.center
    }
    
    private func fetchNotifications(){
        
        let post = UserPost(identifier: "",
                            posttype: .photo,
                            thumbnailImage: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!,
                            postURL: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!, caption: "Yo", likesCount: [], comments: [], postDate: Date(), tagUsers: [])
        for x in 1...100 {
            
            let model = userNotification(type: x%2 == 0 ? .like(post: post) : .follow(state: .not_following), text: "@jitu.171 liked your pic", user: User(username: "jitu.171", name: (first: "", last: ""), profilePicture: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!, birthdate: Date(), gender: .male, counts: UserCount(follower: 1, following: 1, posts: 1), joinDate: Date()))
            
            models.append(model)
        }
    }
    
    private func addNoNotificationsView(){
        tableView.isHidden = true
        view.addSubview(noNotificationsView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            //Like Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsLikeTableViewCell.identifier, for: indexPath) as! NotificationsLikeTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            //follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsFollowerTableViewCell.identifier, for: indexPath) as! NotificationsFollowerTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
       
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
}


extension NotificationViewController: NotificationsLikeTableViewCellDelegate, NotificationsFollowerTableViewCellDelegate{
    func didTapFollowUnfollowButton(model: userNotification) {
        print("Tapped Button")
        // Follow/Unfollow
    }
    
    func didTapRelatedPostButton(model: userNotification) {
        print("Tapped Post")
        //Open Post
    }
}
