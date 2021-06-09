//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar:  UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
     private var models =  [UserPost]()
    
    private var collectionView: UICollectionView?
    private var tabSearchCollectionView: UICollectionView?
    
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
       
        configureSearchBar()
        configureExploreCollection()
        configureTabs()
        
        view.addSubview(dimmedView)
    }
    
    
    private func configureTabs(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 55)
        layout.scrollDirection = .horizontal
        tabSearchCollectionView = UICollectionView(frame: .zero,
                                                   collectionViewLayout: layout)
        tabSearchCollectionView?.backgroundColor = .systemBackground
        tabSearchCollectionView?.isHidden = true
        guard let tabSearchCollectionView = tabSearchCollectionView else {
            return
        }
        tabSearchCollectionView.delegate = self
        tabSearchCollectionView.dataSource = self
        
        view.addSubview(tabSearchCollectionView)
        
    }
    
    private func configureSearchBar(){
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configureExploreCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3 , height: (view.width-4)/3)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.backgroundColor = .systemBackground
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 75)
    }
}

extension ExploreViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .done, target: self, action: #selector(didTapCancel))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.3,animations: {
            self.dimmedView.alpha = 0.5
        }){
            done in
            if done {
                self.tabSearchCollectionView?.isHidden = false
            }
        }
    }
    
    @objc private func didTapCancel(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        tabSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.3,animations: {
            self.dimmedView.alpha = 0.5
        }){ done in
            if done{
            self.dimmedView.isHidden = true
            }
        }
    }
    
    private func query(_ text: String){
        // Perform search in backend
    }
}


extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabSearchCollectionView {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else{
            return UICollectionViewCell()
        }
       // cell.configure(with: post)
        
        //Mock Model
        let user = User(username: "jitu.171", name: (first: "", last: ""), profilePicture: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!, birthdate: Date(), gender: .male, counts: UserCount(follower: 1, following: 1, posts: 1), joinDate: Date())
        
        let post = UserPost(identifier: "",
                            posttype: .photo,
                            thumbnailImage: URL(string: "https://yt3.ggpht.com/ytc/AAUvwnjyKzvLyxW8YJV6nSRC71JFUikN6ICJn_v-53mz1Q=s900-c-k-c0x00ffffff-no-rj")!,
                            postURL: URL(string: "https://yt3.ggpht.com/ytc/AAUvwnjyKzvLyxW8YJV6nSRC71JFUikN6ICJn_v-53mz1Q=s900-c-k-c0x00ffffff-no-rj")!, caption: "Yo", likesCount: [], comments: [], postDate: Date(), tagUsers: [], owner: user)
        
        cell.configure(with: post)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let user = User(username: "jitu.171", name: (first: "", last: ""), profilePicture: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!, birthdate: Date(), gender: .male, counts: UserCount(follower: 1, following: 1, posts: 1), joinDate: Date())
        
        let post = UserPost(identifier: "",
                            posttype: .photo,
                            thumbnailImage: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!,
                            postURL: URL(string: "https://lh3.googleusercontent.com/ogw/ADea4I4IM4YJNCrA9jACfUrmeywfnLXkcxKXQvKHP79e71w=s64-c-mo")!, caption: "Yo", likesCount: [], comments: [], postDate: Date(), tagUsers: [], owner: user)
      //  let model = models[indexPath.row]
        let vc = PostViewController(model: post)
        vc.title = post.posttype.rawValue
        navigationController?.pushViewController(vc , animated: true)
    }
}
