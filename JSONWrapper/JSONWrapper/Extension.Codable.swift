//
//  Extetion.Codable.swift
//  JSONWrapper
//
//  Created by PC on 2022/9/7.
//

import Foundation


/**
 功能：
    1. Dictionary 追加 Sub Dictionary
    2. Model转换
    3. Model合并
 */


public enum MergeMode: Int {
    /** 合并两个model，如果具有相同属性时会使用第二个model去覆盖第一个model对应的属性值。*/
    case `default` = 0
    /** 合并两个model，只会覆盖第一个model中值为nil的属性*/
    case coverNil
}


extension Dictionary{

    /**
     功能：字典追加
     mode：字典追加合并模式
     */
    mutating func append(_ item:Dictionary<Key, Value>, _ mode:MergeMode = .default ) {
        if mode == .coverNil {
            for key in item.keys {
                if let value = self[key] {
                    //self.key存在但是其值为nil时，需要替换对应属性值。
//                    print("nil key:\(key)   value:\(value)")
                    if "\(value)" == "nil" {
                        self[key] = item[key]
                    }
                }else{
                    //self.key不存在，直接添加新key
                    self[key] = item[key]
                }
            }
        }else{
            for key in item.keys {
                self[key] = item[key]
            }
        }
    }

}



extension Encodable{

    /**
     功能：转化为JSON对象
     isStrict: 是否按严格标准获取JSON对象， default true。 true:转换失败时返回nil；false:转换失败时返回自己。
     */
    func json(_ isStrict:Bool = true) -> Any?{
        var json: Any? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
        } catch  {
            //https://cloud.tencent.com/developer/article/1905318?from=15425
            if isStrict {
                print("json Error:\(error)")
            }else{
                print("json Error: 直接返回对象自己")
                return self
            }
        }
        return json
    }

    /**
     功能：转化为JSON Data
     isStrict: 是否按严格标准获取JSON对象， default true。 true:转换失败时返回nil；false:转换失败时返回一个空字典组成的data。
     */
    func jsonData(_ isStrict:Bool = true) ->Data? {
        var jsonData:Data? = nil
        do {
            let encoder = JSONEncoder()
            jsonData = try encoder.encode(self)
        } catch  {
            if isStrict {
                print("jsonData Error:\(error)")
            }else{
                print("jsonData Error: 直接返回一个空的Data()")
                let dict:[String:Any] = [:]
                jsonData = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
//                return Data()
            }
        }
        return jsonData
    }

    /**
     功能：转化为JSON String
     isStrict: 是否按严格标准获取JSON String， default true。 true:转换失败时返回nil；false:转换失败时返回自己。
     */
    func jsonString(_ isStrict:Bool = true) ->String? {
        var jsonString:String? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            jsonString = String(data: data, encoding: .utf8)
        } catch  {
            if isStrict {
                print("jsonString Error:\(error)")
            }else{
                print("jsonString Error: 直接返回对象自己")
                return "\(self)"
            }
        }
        return jsonString
    }

}



/**
 功能：对象类型转换；将model对象转换为新type类型对应的对象。
 使用限制：
        1.两个model的所有相同属性的类型必须要保持一致，否则转换失败。
 */
func modelToModel<T,NEW>(model:T,  convertType type:NEW.Type,  _ isStrict:Bool = true) -> NEW? where T:Encodable,NEW:Decodable {
    print("modelToModel     original mode:\(model ))      convert Type:\(NEW.self) ")
    do {
        var decoderData:Data
        if let jsonData = model.jsonData(isStrict) {
            decoderData = jsonData
        }else{
            decoderData = Data()
        }
        let decoder = JSONDecoder()
        let newModel = try decoder.decode(type, from: decoderData)
        return newModel
    } catch  {
        if isStrict {
            print("⚠️modelToModel: '\(T.self) convertTo \(type)'  Error:  \(error)")
        }else{
            do {
                let dict:[String:Any] = [:];
                let decoderData = try JSONSerialization.data(withJSONObject:dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
                let decoder = JSONDecoder()
                let fastModel = try decoder.decode(type, from: decoderData)
                print("⚠️modelToModel: '\(T.self) convertTo \(type)'  Error:  直接使用一个空字典创建 \(type) 对象！  ")
                return fastModel
            } catch  {
                print("⚠️modelToModel: '\(T.self) convertTo \(type)'  Error:  直接使用一个空字典创建 \(type) 对象时出现错误!  Error: \(error)")
            }
        }
    }
    return nil
}




/**
 功能：将model2的属性值合并到model1中，如果合并失败直接返回第一个model。
 使用限制：
        1.两个model的所有相同属性的类型必须要保持一致，否则合并失败。
 */
func modelToMerge<T,V>(model model1:T, merge model2:V , _ mode:MergeMode = .default) -> T where T:Codable, V:Encodable{
    print("modelToMerge     model1:\(model1)       model2:\(model2) ")
    do {
        let encoder = JSONEncoder()
        var resDict:Dictionary<String, Any?> = [:]

        var data = try encoder.encode(model1)

        var parsedObject: Any? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
        if let dict = parsedObject as? Dictionary<String, Any?>{
            resDict.append(dict)
        }

        data = try encoder.encode(model2)
        parsedObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
        if let dict = parsedObject as? Dictionary<String, Any?>{
            resDict.append(dict,mode)
        }

        //JSONDecoder解码到指定对象
        if let decoderData = try? JSONSerialization.data(withJSONObject: resDict, options: JSONSerialization.WritingOptions.sortedKeys) {
            print("resDict:\(resDict)")
            let decoder = JSONDecoder()
            let newModel = try decoder.decode(T.self, from: decoderData)
            return newModel
        }
    } catch  {
        print("⚠️modelToMerge:  Error:\n \(error)")
    }

    return model1
}


