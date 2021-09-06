//
//  DataModel.swift
//  SampleMVVMApp
//
//  Created by Hammad Zafar on 05/09/2021.
//

import Foundation
import RealmSwift

/*
{
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  }
*/

class TypiCodeDataModel : Object, Codable {
    @objc dynamic var albumId : Int
    @objc dynamic var id : Int
    @objc dynamic var title : String
    @objc dynamic var url : String
    @objc dynamic var thumbnailUrl : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case albumId = "albumId"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    override init() {
        self.albumId = 0
        self.id = 0
        self.title = ""
        self.url = ""
        self.thumbnailUrl = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)!
        id = try values.decodeIfPresent(Int.self, forKey: .id)!
        title = try values.decodeIfPresent(String.self, forKey: .title)!
        url = try values.decodeIfPresent(String.self, forKey: .url)!
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)!
    }
    
    init(albumId : Int, id: Int, title: String, url : String, thumbnailUrl : String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
}
