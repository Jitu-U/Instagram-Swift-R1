//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Jitesh gamit on 25/05/21.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController, UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()

    private var models = [[EditProfileFormModel]]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save",
                                                            style: .done ,
                                                            target: self ,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel",
                                                            style: .done ,
                                                            target: self ,
                                                            action: #selector(didTapCancel))
    }
    
    private func configureModels(){
        // NAME , USERNAME , BIO , WEBSITE
        let section1Labels = ["Name","Username","Bio","Website"]
        var section1 = [EditProfileFormModel ]()
        for label in section1Labels{
             let model = EditProfileFormModel(label:  label,
                                              placeholder: "enter \(label)...",
                                               value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        
        // EMAIL , PHONE , GENDER
        
        let section2Labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileFormModel ]()
        for label in section2Labels{
             let model = EditProfileFormModel(label:  label,
                                              placeholder: "enter \(label)...",
                                               value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    //MARK: -Table View
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height/5))
        let size = header.height/1.5
        let profilePicBtn = UIButton(frame: CGRect(x: (view.width - size)/2,
                                                   y: (header.height - size)/2,
                                                   width: size,
                                                   height: size))
        
        header.addSubview(profilePicBtn)
        profilePicBtn.layer.masksToBounds = true
        profilePicBtn.layer.cornerRadius = size/2.0
        profilePicBtn.addTarget(self,
                                action: #selector(didTapProfilePicBtn),
                                for: .touchUpInside)
        profilePicBtn.setBackgroundImage(UIImage(systemName: "person.fill"),
                                      for: .normal)
        profilePicBtn.tintColor = .label
        profilePicBtn.layer.borderWidth = 1
        profilePicBtn.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc private func didTapProfilePicBtn(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row ]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath ) as! FormTableViewCell
        cell.configureCell(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
    // MARK: - Actions
    
    @objc private func didTapSave(){
        // Save info to databse
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePic(){
        let actionSheet = UIAlertController(title: "Profile Pic",
                                            message: "change profile picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }
}

extension EditProfileViewController: formTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
       //Update Model
        print(updatedModel.value ?? "Nil")
    }
}
