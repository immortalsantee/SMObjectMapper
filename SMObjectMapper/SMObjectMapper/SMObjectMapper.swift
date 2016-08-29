//
//  SMObjectMapper.swift
//  SMObjectMapping
//
//  Created by Santosh Maharjan on 8/25/16.
//  Copyright © 2016 Cyclone Nepal Info Tech. All rights reserved.
//  URL : www.maharjansantosh.com.np

import Foundation

/**
    JSON = [String : AnyObject]
 */
public typealias JSON = [String : AnyObject]
infix operator >>> {
    associativity right
    precedence 160
}

/**
    JSON protocol
 */
public protocol SMMapJson {
    init?(json: JSON)
}

/**
    AnyObject Protocol
 */
public protocol SMMapAnyObject {
    init?(json: AnyObject)
}


//MARK: - MapJson Or MapAnyObject Module Object
/**
    Returns your module object which confirms to `MapJson` Protocol
 */
public func >>> <T: SMMapJson>(json: JSON, key: String) -> T? {
    return findModuleObjectFromKey(key)(json)
}

/**
    Returns your module object which confirm `MapJson` Protocol
 */
public func findModuleObjectFromKey<T: SMMapJson>(key:String) -> JSON -> T? {
    return {
        json in
        
        if let _json = json[key] as? JSON {
            return T(json: _json)
        }
        return nil
    }
}



/**
    Returns your module object which confirms `MapAnyObject` Protocol
 */
public func >>> <T : SMMapAnyObject> (json: JSON, key: String) -> T? {
    return findAnyObjectFromKey(key)(json)
}

/**
    Returns your module object which confirm `MapAnyObject` Protocol
 */
public func findAnyObjectFromKey<T : SMMapAnyObject>(key:String) -> JSON -> T? {
    return {
        json in
        
        if let anyObject = json[key] {
            if let anyObject = T(json :anyObject) {
                return anyObject
            }
        }
        return nil
    }
}





//MARK: - Array Of MapJson Or MapAnyObject Module Objects
/**
    Returns array of your module which confirms to `MapAnyObject` Protocol from JSON
 */
public func >>> <T where T:SMMapAnyObject>(json: JSON, key: String) -> [T]? {
    return findAnyObjectModuleArrayFromKey(key)(json)
}

/**
    Returns array of your module which confirm `MapAnyObject` Protocol
 */
public func findAnyObjectModuleArrayFromKey<T where T:SMMapAnyObject>(key:String) -> JSON -> [T]? {
    return {
        json in
        var moduleArray : [T] = []
        
        for (_, value) in json  {
            if let anyObjects = value as? [AnyObject] {
                for anyObject in anyObjects
                {
                    if let module = T(json : anyObject){
                        moduleArray.append(module)
                    }
                }
            }
        }
        return moduleArray
    }
}



/**
 Returns array of `class` or `struct` or `enum` objects which confirms to `MapJson` Protocol from AnyObject
 */
public func >>> <T : SMMapJson> (any : AnyObject, emptyKey : String) -> [T]? {
    return findAnyObjectArrayFromKey(emptyKey)(any)
}

/**
 Returns array of objects which confirms `MapJson` protocol
 */
public func findAnyObjectArrayFromKey<T: SMMapJson>(emptyKey:String) -> AnyObject -> [T]? {
    return {
        anyObject in
        var moduleArray:[T] = []
        
        if let jsonArray = anyObject as? [JSON] {
            for json in jsonArray {
                if let json = T(json: json) {
                    moduleArray.append(json)
                }
            }
        }
        
        return moduleArray
    }
}





//MARK: - Returns Default datatype objects  -> `String` or `Bool` or `Double` from `AnyObject`
/**
    Returns required type -> `String` or `Bool` or `Double` from `AnyObject`
 */
public func >>> <T> (any : AnyObject, key : String) -> T? {
    return findAnyObjectFromKey(key)(any)
}

/**
    Returns required type
 */
public func findAnyObjectFromKey<T>(key:String) -> AnyObject -> T? {
    return {
        anyObject in
        
        if let _anyObject = anyObject[key] as? T {
            return _anyObject
        }
        
        return nil
    }
}



/**
 Returns required type -> `String` or `Bool` or `Double` from `JSON`
 */
public func >>> <T>(json: JSON, key: String) -> T? {
    return findModuleObjectFromKey(key)(json)
}

/**
 Returns required type
 */
public func findModuleObjectFromKey<T>(key:String) -> JSON -> T? {
    return {
        json in
        
        if let _json = json[key] as? T {
            return _json
        }
        return nil
    }
}