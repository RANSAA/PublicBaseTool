//
//  TestModel.swift
//  JSONWrapper
//
//  Created by PC on 2022/12/11.
//

import Foundation



@propertyWrapper
struct JSONString {
    private var raw: String!
    private var defaultRaw:String{
        return "null"
    }
    private var rawVaule:String{
        if let raw = raw {
            return raw
        }
        return defaultRaw
    }
    
    var wrappedValue: String! {
        set{ if let value = newValue { raw = value } }
        get{ return rawVaule }
    }
    init() { raw = defaultRaw }
    init(wrappedValue: String!) {
        self.init()
        if let vaule = wrappedValue {
            raw = vaule
        }
    }
}

extension JSONString:Decodable{
    init(from decoder: Decoder) throws {
        let contariner = try decoder.singleValueContainer()
        wrappedValue = try contariner.decode(String.self)
    }
    
}

extension JSONString: Encodable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

struct TestModel:Codable {
    @JSONString var a:String?
    @JSONString var b:String?

    @JSONWrapper.JSONString var c:String



    func test(){
        let obj = TestModel(a: .init(), b: .init(), c: .init())
    }
}


