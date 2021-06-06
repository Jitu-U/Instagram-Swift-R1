//
//  ListViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import UIKit

class ListViewController: UIViewController {

    
    private var data = [userRelationshipModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return tableView
    }()
    
    init(data: [userRelationshipModel]){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
        
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Go to Public profile of user
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
     
}


extension ListViewController: userFollowTableViewCellDelegate{
    func didTapfollowUnfollowButton(model: userRelationshipModel) {
        switch  model.type {
        case .following: break
            //perform firebase update to unfollow
        case .not_following: break
            //perform firebase update to follow
        }
    }
}
