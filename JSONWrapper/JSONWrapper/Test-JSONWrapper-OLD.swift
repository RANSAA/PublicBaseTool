//
//  Test-JSONWrapper-OLD.swift
//  JSONWrapper
//
//  Created by PC on 2022/9/8.
//

import Foundation


class A: NSString {
    @JSONWrapperString var a: String! = nil
    @JSONWrapperString var b: String? = "22222"
    @JSONWrapperArray  var c: [Any]!
}


func funScan(){
    let str = "1223hu89"
    let scan: Scanner = Scanner(string: str)
    print(scan.scanInt())
    var p: Int = 0;
//        scan.scanLocation = 0;
    scan.currentIndex = str.startIndex;
    scan.scanInt(&p)
    print(scan.scanInt(&p))
    print(p)
}




func test_JSONWrapper_OLD(){
    print("begin......")
    let a = A()
    print(a.a)
    print(a.b)

    a.c = [1,2,3,"4"];
    print(a.c)
    print(a.a)
    a.a = nil
    print(a.a)
    a.a = "nil555"
    print(a.a)



    funScan()
}
