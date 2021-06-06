//
//  Models.swift
//  Instagram
//
//  Created by Jitesh gamit on 01/06/21.
//

import Foundation

enum Gender{
    case male, female , others
}

public struct  User {
    let username: String
    let name: (first: String, last: String)
    let profilePicture: URL
    let birthdate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let follower: Int
    let following: Int
    let posts: Int
}

public enum UserPostType{
    case photo, video
}

///User Post Model
public struct UserPost{
    let identifier: String
    let posttype: UserPostType
    let thumbnailImage: URL
    let postURL: URL //either Video URL or HQ image URl
    let caption: String?
    let likesCount: [postLike]
    let comments: [postComment]
    let postDate: Date
    let tagUsers: [String]
}

struct postComment {
    let identifier: String
    let username: String
    let comment: String
    let postedDate: Date
    let likes: [commentLike]
}

struct postLike {
    let postIdentifier: String
    let username: String
}

struct commentLike {
    let commentIdentifier: String
    let username: String
}
