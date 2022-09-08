//
//  Description.swift
//  FirBuilder
//
//  Created by PC on 2022/2/8.
//

import Foundation





//let a = ModelA(a:"string",c:222)
//let b = ModelB.par(a)
//
//
//printAllIvars(a)
//printAllIvars(b)








let a1 = ModelA(a:.init(wrappedValue: "A-string"),c:.init(wrappedValue: 11111))
let a2 = ModelA(b:.init(wrappedValue: true),c:.init(wrappedValue: 22222))
let a3 = "STRING TYPE"
let a4 = 123

let b1 = ModelB(a:.init(wrappedValue: "B-string"),b: .init(wrappedValue: true),c:.init(wrappedValue: 999))
let b2 = ModelB(b:.init(wrappedValue: false))

var dic = ["a":"aaaaa","b":nil,"c":123, "d":456] as [String : Any?]

let meargA = modelToMerge(model:a1, merge:b1, .coverNil)
//print("modelToMerge:\(meargA)     type:\(type(of: meargA))" )

printAllIvars(meargA)
print(meargA.b)

print("json:\(b2.json())")
print("jsonString:\(b2.jsonString())")


//print("meargA start:")
//printAllIvars(meargA)
//print(meargA)
//print("meargA end:")
//
//
//
//
//print("json:\(a1.json())")
//print("jsonString:\(a1.jsonString())")
//
//print("json:\(a3.json(false))")
//print("jsonString:\(a3.jsonString())")
//
//print("json:\(a4.json(false))")
//print("jsonString:\(a4.jsonString())")



//let toModel2 = modelToModel(model:a1, convertType: ModelB.self, false)
//print("modelToModel:\(toModel2)     type:\(type(of: toModel2))" )
//print("g:\(toModel2?.g)")
//
//
//let b3 = ModelB(b:false,g: .init(wrappedValue: "init default string.."))
////let b3 = ModelB(b:false,g: "init default string.." )
////
//print("b:\(b3)")


//let jsonData = a1.jsonData()
//
//let encoder = JSONEncoder()
//var data = try! encoder.encode(a1)
//data = try! JSONSerialization.data(withJSONObject: dic, options: .init(rawValue: 0))


//let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
//print("json:\(json)")




var dic1 = ["a":"aaaaa","b":nil,"c":123, "d":456] as [String : Any?]
var dic2 = ["a":"AAAAA","b":"BBBB","c":nil,"e":777] as [String : Any?]
//print(dic1)

//dic1.append(dic2)
//dic1.append(dic2, .coverNil)
//print(dic1)

//dic2.append(dic1)
//dic2.append(dic1, .coverNil)
//print(dic2)





test_JSONWrapper_OLD()
