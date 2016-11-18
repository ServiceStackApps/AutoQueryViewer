//
//  AppData.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/16/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

open class AppData : NSObject
{
    var client = JsonServiceClient(baseUrl: "http://servicestack.net")
    
    var imageCache:[String:UIImage] = [:]
 
    override init(){
        super.init()
        self.loadDefaultImageCaches()
    }

    func loadDefaultImageCaches() {
        imageCache = [:]
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 858, height: 689), false, 0.0)
        imageCache["blankScreenshot"] = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0.0)
        imageCache["clearIcon"] = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageCache["database"] = UIImage(named: "database")
        imageCache["bg-alpha"] = UIImage(named: "bg-alpha")
    }
    
    @discardableResult open func loadAllImagesAsync(_ urls:[String]) -> Promise<[String:UIImage?]> {
        var images = [String:UIImage?]()
        return Promise<[String:UIImage?]> { (complete, reject) in
            for url in urls {
                self.loadImageAsync(url)
                    .then { (img:UIImage?) -> Void in
                        images[url] = img
                        if images.count == urls.count {
                            return complete(images)
                        }
                    }
            }
        }
    }
    
    @discardableResult open func loadImageAsync(_ url:String) -> Promise<UIImage?> {
        if let image = imageCache[url] {
            return Promise<UIImage?> { (complete, reject) in complete(image) }
        }
        
        return client.getDataAsync(url)
            .then { (data:Data) -> UIImage? in
                if let image = UIImage(data:data) {
                    self.imageCache[url] = image
                    return image
                }
                return nil
            }
    }
    
    /* KVO Observable helpers */
    var observedProperties = [NSObject:[String]]()
    var ctx:AnyObject = 1 as AnyObject
    
    open func observe(_ observer: NSObject, properties:[String]) {
        for property in properties {
            self.observe(observer, property: property)
        }
    }
    
    open func observe(_ observer: NSObject, property:String) {
        self.addObserver(observer, forKeyPath: property, options: [.new, .old], context: &ctx)
        
        var properties = observedProperties[observer] ?? [String]()
        properties.append(property)
        observedProperties[observer] = properties
    }
    
    open func unobserve(_ observer: NSObject) {
        if let properties = observedProperties[observer] {
            for property in properties {
                self.removeObserver(observer, forKeyPath: property, context: &ctx)
            }
        }
    }
    
    func resetCache() {
        loadDefaultImageCaches()
    }
}

func saveDefaultSetting(_ key:String, value:String) {
    UserDefaults.standard.set(value, forKey: key)
}
func getDefaultSetting(_ key:String) -> String? {
    return UserDefaults.standard.string(forKey: key)
}



