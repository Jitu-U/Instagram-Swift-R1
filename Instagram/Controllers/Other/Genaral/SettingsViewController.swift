//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import SafariServices
import UIKit


///Menu Item model
struct settingCellModel {
    let title: String
    let handler:(() -> Void)
    
}

///view controller  to show settings menu
final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[settingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        data.append([
            settingCellModel(title: "Edit Profile"){[weak self ] in
                self?.didTapEdit()
            },
            settingCellModel(title: "Invite friends"){[weak self ] in
                self?.didTapInvite()
            },
            settingCellModel(title: "Save Original Posts"){[weak self ] in
                self?.didTapSaveOriginalPosts()
            }
         ])
        
        data.append([
            settingCellModel(title: "Terms of Service"){[weak self ] in
                self?.openURL(type: .terms)
            },
            settingCellModel(title: "Privacy Policy"){[weak self ] in
                self?.openURL(type: .privacy)
            },
            settingCellModel(title: "Help and feedback"){[weak self ] in
                self?.openURL(type: .help)
            }
         ])
        
        data.append([
            settingCellModel(title: "About us"){[weak self ] in
                self?.openURL(type: .about)
            }
        ])
        
        data.append([
            settingCellModel(title: "Log out"){
                //Memory leakage
                [weak self ] in
                self?.didTapLogout()
                
            }
         ])
    }
    
    enum settingsURLType{
        case terms, privacy, help, about
    }
    
    private func openURL(type: settingsURLType){
        
        let urlString: String
        switch type {
        case .terms: urlString = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
        case .about: urlString = "https://www.instagram.com/about/us/"
        }
        
        guard  let url = URL(string: urlString ) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    ///Edit Profile
    private func didTapEdit(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile Bitch"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    ///Invite friends
    private func didTapInvite(){
        
    }
    
    ///Save Original Posts
    private func didTapSaveOriginalPosts(){
        
    }
    

    
    ///Logout
    private func didTapLogout(){
        
        //Ask if you wanna Logout
        let actionSheet = UIAlertController(title: "Logout ⚠️", message: "Are you sure you want to logout ?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
            _ in
            
            //Try to logout
        AuthManager.shared.logOut(completion: {success in
            DispatchQueue.main.async {
                if success{
                    //Go to login page
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC,animated: true){
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                } else {
                    //Error Signing out
                }
            }
        })
            
        }))
        
        
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
            
    }
}

extension SettingsViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
