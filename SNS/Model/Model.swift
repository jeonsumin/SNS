//
//  Model.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//

import Foundation


enum Gender{
    case male,female, other
}

struct User {
    let username: String
    let bio: String
    let name: String
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date

}
struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}



public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}



//사용자 게시글
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let commonts:[PostComment]
    let createDate: Date
    let taggeduser: [String]
    let owner : User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
