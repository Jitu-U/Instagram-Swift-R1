//
//  ViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import FirebaseAuth
import UIKit

struct HomeFeedRenderViewModel {
    let header: postRenderViewModel
    let post: postRenderViewModel
    let action: postRenderViewModel
    let comments: postRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel ]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        createMockModels()
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let Story = UIBarButtonItem(image: UIImage(systemName: "camera", withConfiguration: UIImage.SymbolConfiguration(pointSize: 21, weight: .light))?.withTintColor(UIColor.label),
                                    style: .done,target: self, action: #selector(didTapStoryButton))
        Story.tintColor = .label
        let messenger = UIBarButtonItem(image: UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(pointSize: 21, weight: .light)), style: .done, target: self, action: #selector(didTapMessageButton))
        messenger.tintColor = .label
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "instalogofullbg"))
        navigationItem.leftBarButtonItem = Story
        navigationItem.rightBarButtonItem = messenger
       
    }
    
    
    @objc private func didTapStoryButton(){
        
    }
    
    @objc private func didTapMessageButton(){
        let vc = MessengerViewController()
        vc.title = "Messenger"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Mock Models
    private func createMockModels(){
        
        let user = User(username: "jitu.171", name: (first: "", last: ""), profilePicture: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!, birthdate: Date(), gender: .male, counts: UserCount(follower: 1, following: 1, posts: 1), joinDate: Date())
        
        let post = UserPost(identifier: "",
                            posttype: .photo,
                            thumbnailImage: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!,
                            postURL: URL(string: "https://yt3.ggpht.com/ytc/AAUvwnjyKzvLyxW8YJV6nSRC71JFUikN6ICJn_v-53mz1Q=s900-c-k-c0x00ffffff-no-rj")!, caption: "Yo", likesCount: [], comments: [], postDate: Date(), tagUsers: [], owner: user)
        
        var comments = [postComment]()
        for x in 0..<10 {
            comments.append(postComment(identifier: "\(x)", username: "@bellieeilish", comment: "OMG", postedDate: Date(), likes: []))
        }
        
        for _ in 0..<5{
            let viewModel = HomeFeedRenderViewModel(header: postRenderViewModel(renderType: .header(provider: user)),
                                                    post: postRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    action: postRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: postRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleAuthentication()
    
    }
    
    private func handleAuthentication(){
        //check auth status
        if Auth.auth().currentUser == nil {
            //Show Login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC,animated: false)
            
        }
    }
    


}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        if section == 0 {
            model = feedRenderModels[0]
        }
        else{
            let position = section % 4 == 0 ? section/4 : ((section - (section % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = section % 4
        
        if subSection == 0 {
            //Header
            return 1
        }
        else if subSection == 1{
            //Post
            return 1
        }
        else if subSection == 2{
            //Actions
            return 1
        }
        else if subSection == 3{
            //Comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case.comments(let comments):return comments.count > 2 ? 2 : comments.count
            case .header, .primaryContent, .actions: return 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        if indexPath.section == 0 {
            model = feedRenderModels[0]
        }
        else{
            let position = indexPath.section % 4 == 0 ? indexPath.section/4 : ((indexPath.section - (indexPath.section % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            //Header
            
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .primaryContent, .actions: return UITableViewCell()
            }
        }
        else if subSection == 1{
            //Post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post )
                return cell
            case .comments, .header , .actions: return UITableViewCell()
            }
        }
        else if subSection == 2{
            //Actions
            switch model.action.renderType {
            case.actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .comments, .primaryContent, .header : return UITableViewCell()
            }
        }
        else if subSection == 3{
            //Comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header, .primaryContent, .actions: return UITableViewCell()
            }
        }
        
        return UITableViewCell()
         
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            //header
            return 70
        }
        else if subSection == 1 {
            //post
            return tableView.width
        }
        else if subSection == 2 {
            //actions
            return 60
        }
        else if subSection == 3 {
            //comments
            return 50
        }
        else{
            return 0
        }
    }
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate, IGFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        
    }
    
    func didTapCommentButton() {
        
    }
    
    func didTapSendButton() {
        
    }
    
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil , preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report post", style: .destructive, handler: {[weak self] _ in
            self?.reportPost()
        } ))
        actionSheet.addAction(UIAlertAction(title: "Copy URL", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func reportPost(){
        
    }
}

