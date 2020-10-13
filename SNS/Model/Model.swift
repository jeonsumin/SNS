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
    let birthDate: Int
    let gender: Gender
    let counts: UserCount
    let joinDate: Date

}
struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType {
    case photo, video
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
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
