//
//  Feed.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

final class Feed: Codable {
    var feedId: UInt
    var avatar: String = ""
    var userName: String = ""
    var content: String? = ""
    var isFavor: Bool! = false
    var favor: UInt!
    var images: [String]! = []
    var comments: [Comment]?

//    var identifier:UUID
//    //TK 自定义解码测试
//    init(from decoder: Decoder) throws {
//        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
//        feedId = try keyedContainer.decode(UInt.self, forKey: .feedId)
//        avatar = try keyedContainer.decode(String.self, forKey: .avatar)
//        userName =  try keyedContainer.decode(String.self, forKey: CodingKeys.userName)
//
//        content = try keyedContainer.decodeIfPresent(String.self, forKey: .content)
//        isFavor = try keyedContainer.decodeIfPresent(Bool.self, forKey: .isFavor)
//        favor =  try keyedContainer.decodeIfPresent(UInt.self, forKey: CodingKeys.favor)
//
//        images = try keyedContainer.decodeIfPresent([String].self, forKey: .images)
//        comments = try keyedContainer.decodeIfPresent([Comment].self, forKey: .comments)
//        identifier =  UUID()
//
//        print("uuid:\(identifier)")
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case feedId
//        case avatar
//        case userName
//        case content
//        case isFavor
//        case favor
//        case images
//        case comments
//        case identifier
//    }
}

extension Feed: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return feedId as NSObjectProtocol
//        return identifier as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? Feed else { return false }
        return feedId == object.feedId
//        return identifier == object.identifier
    }
}

extension Feed: Equatable {
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        return lhs.isEqual(toDiffableObject: rhs)
    }
}
