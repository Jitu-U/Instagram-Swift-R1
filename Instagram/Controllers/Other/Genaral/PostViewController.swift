//
//  PostViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import UIKit

/*
 - Header Model (Profile Name)
 -  Post model (Post Image or video)
 -  Action Model (Like share)
 -  n - General Models for comments
 */


///States of a Rendered cell
enum postRenderType{
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [postComment])
}


///Model of rendered post
struct postRenderViewModel {
    let renderType: postRenderType
}




class  PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderedModel = [postRenderViewModel]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        //Reister Cells
        
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    //MARK: - Init
    
    init(model: UserPost? ) {
        self.model = model
        super .init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels(){
        guard let userPostModel = self.model else {
            return
        }
        //Header
        renderedModel.append(postRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //Post
        renderedModel.append(postRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        //Actions
        renderedModel.append(postRenderViewModel(renderType: .actions(provider: "")))
        
        //10 comments
        var comments = [postComment]()
        for x in 0..<10 {
            comments.append(postComment(identifier:  "123_\(x)",
                                        username: "@billieeilish",
                                        comment: "Amayzing ❤️",
                                        postedDate: Date(),
                                        likes: []))
        }
        renderedModel.append(postRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
         
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderedModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderedModel[section].renderType {
            case.actions(_): return 1
            case .header(_): return 1
            case .primaryContent(_): return 1
            case .comments(let comments): return (comments.count > 10 ?  10 : comments.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderedModel[indexPath.section]
        switch model.renderType{
        case.actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .header(let header):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderedModel[indexPath.section]
        switch model.renderType {
            case.actions(_): return 60
            case .header(_): return 70
        case .primaryContent(_): return tableView.width
        case .comments(_): return 50
        }
    }
}
