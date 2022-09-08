//
//  Model.swift
//  JSONWrapper
//
//  Created by PC on 2022/9/8.
//

import Foundation







struct ModelA:Codable{
    @JSONWrapper.JSONString var a:String
    @JSONWrapper.JSONFalse var b:Bool
    @JSONWrapper.JSONInt var c:Int
}



struct ModelB:Encodable{
    @JSONWrapper.JSONString var a:String

    @JSONWrapper.JSONFalse var b:Bool

    @JSONWrapper.JSONInt var c:Int

    @JSONWrapper.JSONInt var d:Int = 999

    @JSONWrapper.JSONString var e:String




    private enum CodingKeys: String, CodingKey {
//        case a = "A"
//        case b = "B"
//        case c = "C"
//        case d = "D"

        case a,b,c,d
    }
}

extension ModelB:Decodable{



    
//    init(from decoder: Decoder) throws {
//
//        let dic = decoder.userInfo
//        print("userInfo:\(dic)")
//        print("codingPath:\(decoder.codingPath)")
//        print("self:\(decoder.self)")
//        print("self:\(try? decoder.singleValueContainer())")
//        print("self:\(try? decoder.container(keyedBy: CodingKeys.self) )")
//
//
//
//
////        print("decoder:\(try decoder.unkeyedContainer())")
////        let container = try decoder.singleValueContainer()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        a = try container.decode(String.self, forKey: .a)
//        b = try container.decode(Bool.self, forKey: .b)
//        c = try container.decode(Int.self, forKey: .c)
//        d = try container.decode(Int.self, forKey: .d)
//
//
////        a = try container.decode(String.self)
////        b = try container.decode(Bool.self)
////        c = try container.decode(Int.self)
////        if let dd = try? container.decode(Int.self){
////            d = dd
////        }else{
////            d = 9527
////        }
//
//    }


}

struct ModelC:Codable{
    var a:String?

    var f:Int? = 3333
}



