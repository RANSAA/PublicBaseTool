//
//  JSONWrapper.swift
//
//  JSONToModel See: https://github.com/RANSAA/JSONToModel
//
//  Created by Mac on 2021-08-10.
//  Copyright © 2021 芮淼一线 All rights reserved.
//
/**
 自定义属性包装器，让可选属性总是有一个有效值(即可选属性永远不会为nil)
 主要用于Model中
 */

import Foundation


//@propertyWrapper
//struct JSONWrapperString {
//    private var raw: String!
//    var wrappedValue: String!{
//        set{
//            if newValue != nil {
//                raw = newValue
//            }
//        }
//        get{ return raw }
//    }
//
//    init() { raw = "null" }
//    init(wrappedValue: String!) {
//        self.init()
//        if wrappedValue != nil {
//            raw = wrappedValue
//        }
//    }
//}

@propertyWrapper
struct JSONWrapperString {
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


@propertyWrapper
struct JSONWrapperInt {
    private var raw: Int!
    var wrappedValue: Int!{
        set{
            if newValue != nil {
                raw = newValue
            }
        }
        get{ return raw }
    }

    init() { raw = 0 }
    init(wrappedValue: Int!) {
        self.init()
        if wrappedValue != nil {
            raw = wrappedValue
        }
    }
}

@propertyWrapper
struct JSONWrapperFloat {
    private var raw: Float!
    var wrappedValue: Float!{
        set{
            if newValue != nil {
                raw = newValue
            }
        }
        get{ return raw }
    }

    init() { raw = 0.0 }
    init(wrappedValue: Float!) {
        self.init()
        if wrappedValue != nil {
            raw = wrappedValue
        }
    }
}


@propertyWrapper
struct JSONWrapperDouble {
    private var raw: Double!
    var wrappedValue: Double!{
        set{
            if newValue != nil {
                raw = newValue
            }
        }
        get{ return raw }
    }

    init() { raw = 0.0 }
    init(wrappedValue: Double!) {
        self.init()
        if wrappedValue != nil {
            raw = wrappedValue
        }
    }
}


@propertyWrapper
struct JSONWrapperBool {
    private var raw: Bool!
    var wrappedValue: Bool!{
        set{
            if newValue != nil {
                raw = newValue
            }
        }
        get{ return raw }
    }

    init() { raw = false }
    init(wrappedValue: Bool!) {
        self.init()
        if wrappedValue != nil {
            raw = wrappedValue
        }
    }
}


@propertyWrapper
struct JSONWrapperArray {
    private var raw: [Any]!
    var wrappedValue: [Any]!{
        set{
            if newValue != nil {
                raw = newValue
            }
        }
        get{ return raw }
    }

    init() { raw = [] }
    init(wrappedValue: [Any]!) {
        self.init()
        if wrappedValue != nil {
            raw = wrappedValue
        }
    }
}
