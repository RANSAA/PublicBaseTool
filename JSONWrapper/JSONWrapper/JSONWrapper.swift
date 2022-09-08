//
//  JSONWrapper.swift
//  JSONWrapper
//
//  Created by PC on 2022/9/8.
//

import Foundation


/**
 属性包装器：让不可选变量拥有一个默认值，以解决使用使用Codable解析JSON时出现nil值解析失败的问题。

 翻译：https://www.jianshu.com/p/47ad03117e59
 原文：https://www.swiftbysundell.com/tips/default-decoding-values/
 */


protocol JSONWrapperSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

enum JSONWrapper {

}

extension JSONWrapper {
    @propertyWrapper
    struct Wrapper<Source: JSONWrapperSource> {
        typealias Value = Source.Value
        var wrappedValue = Source.defaultValue
    }
}

extension JSONWrapper.Wrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

/**
 通过扩展KeyedDecodingContainer来重载解码特定的类型来完成，在这种情况下，我们仅在存在值的情况下继续解码给定的键，否则我们将返回包装器的空实例
 */
extension KeyedDecodingContainer {
    func decode<T>(_ type: JSONWrapper.Wrapper<T>.Type,
                   forKey key: Key) throws -> JSONWrapper.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension JSONWrapper.Wrapper: Equatable where Value: Equatable {}
extension JSONWrapper.Wrapper: Hashable where Value: Hashable {}
extension JSONWrapper.Wrapper: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

// MARK: - 配置各种类型的默认值
extension JSONWrapper {
    typealias Source = JSONWrapperSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral

    enum Sources {

        enum EmptyList<T: List>: Source {
            static var defaultValue: T { [] }
        }

        enum EmptyMap<T: Map>: Source {
            static var defaultValue: T { [:] }
        }

        enum DefaultString: Source {
            static var defaultValue: String { "" }
        }

        enum True: Source {
            static var defaultValue: Bool { true }
        }

        enum False: Source {
            static var defaultValue: Bool { false }
        }

        enum DefaultInt:Source {
            static var defaultValue: Int { 0 }
        }

        enum DefaultFloat:Source {
            static var defaultValue: Float { 0.0 }
        }

        //可追加更多的自定义类型默认值
    }
    
}

// MARK: - 包装器属性别名
extension JSONWrapper {
    typealias JSONList<T: List> = Wrapper<Sources.EmptyList<T>>
    typealias JSONMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
    typealias JSONTrue = Wrapper<Sources.True>
    typealias JSONFalse = Wrapper<Sources.False>
    typealias JSONString = Wrapper<Sources.DefaultString>
    typealias JSONInt = Wrapper<Sources.DefaultInt>
    typealias JSONFloat = Wrapper<Sources.DefaultFloat>
}






// MARK: - 使用示例
/*
struct Test:Codable{
    @JSONWrapper.JSONString var a:String
    @JSONWrapper.JSONFalse var b:Bool
    @JSONWrapper.JSONInt var c:Int
}

对象创建：
Codable： 使用方式不变，直接JSONEncoder，JSONDecoder操作即可
手动创建： let obj = Test(a:.init(wrappedValue: "test-string")) , 即需要使用属性包装器的init(wrappedValue:)方式创建
**/
