//
//  UIExtensions.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/15/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

extension AutoQueryMetadataResponse {
    
    func getType(_ typeName:String?) -> MetadataType? {
        return typeName != nil
            ? self.types.filter { $0.name == typeName! }.first
            : nil
    }
    
    func getProperties(_ typeName:String?) -> [MetadataPropertyType] {
        var ret = [MetadataPropertyType]()
        
        if typeName != nil {
            var metaType = self.types.filter { $0.name == typeName }.first
            
            while metaType != nil {
                metaType!.properties.forEach { ret.append($0) }
                
                metaType = metaType!.inherits != nil
                    ? self.types.filter { $0.name == metaType!.inherits?.name }.first
                    : nil
            }
        }
        
        return ret
    }
    
    func getQueryTypeTemplate(_ operand:String) -> String? {
        return self.config?.implicitConventions.filter { $0.name == operand }.map { $0.value ?? "" }.first
    }
}

extension MetadataType {
    
    var autoQueryViewerAttr: MetadataAttribute? {
        return self.attributes.filter { $0.name == "AutoQueryViewer" }.first
    }
    
    func getViewerAttrProperty(_ name:String) -> MetadataPropertyType? {
        return self.autoQueryViewerAttr?.args.filter { $0.name?.lowercased() == name.lowercased() }.first
    }
}

extension AutoQueryService {
    func toAutoQueryViewerConfig() -> AutoQueryViewerConfig {
        let to = AutoQueryViewerConfig()
        to.serviceBaseUrl = self.serviceBaseUrl
        to.serviceName = self.serviceName
        to.serviceDescription = self.serviceDescription
        to.serviceIconUrl = self.serviceIconUrl
        to.onlyShowAnnotatedServices = self.onlyShowAnnotatedServices
        to.brandUrl = self.brandUrl
        to.brandImageUrl = self.brandImageUrl
        to.textColor = self.textColor
        to.linkColor = self.linkColor
        to.backgroundColor = self.backgroundColor
        to.backgroundImageUrl = self.backgroundImageUrl
        to.iconUrl = self.iconUrl

        return to
    }
}

extension UIView
{
    var appData:AppData {
        return (UIApplication.shared.delegate as! AppDelegate).appData
    }
}

extension UIViewController
{
    var appData:AppData {
        return (UIApplication.shared.delegate as! AppDelegate).appData
    }
    
    @discardableResult func addBrandImage(_ imageUrl:String?, action:Selector) -> UIImageView? {
        if imageUrl == nil {
            return nil
        }

        let width = view.frame.width / 2
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.width - width, y: 0, width: width, height: 80))
        imageView.contentMode = UIViewContentMode.topRight
        imageView.loadAsync(imageUrl, withSize:imageView.frame.size)

        let btnBrand = UIButton(frame: CGRect(x: self.view.frame.width - 440, y: 0, width: 440, height: 80))
        btnBrand.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        
        view.insertSubview(imageView, belowSubview: view.subviews[1] as UIView) //add after backgroundImage
        view.insertSubview(btnBrand, belowSubview:imageView)
        
        return imageView
    }
}

extension UIImageView {
    @discardableResult func loadAsync(_ url:String?, defaultImage:String? = nil, withSize:CGSize? = nil) -> Promise<UIImage?> {

        self.image = defaultImage != nil ? self.appData.imageCache[defaultImage!]?.scaledInto(withSize) : nil

        if url == nil {
            return Promise<UIImage?> { (complete, reject) in complete(nil) }
        }
        
        return self.appData.loadImageAsync(url!)
            .then { (img:UIImage?) -> UIImage? in
                if img != nil {
                    self.image = img?.scaledInto(withSize)
                }
                return self.image
            }
    }
}

extension CGFloat
{
    public func toHexColor(_ rgbValue:UInt32) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}

extension UIImage
{
    func scaledInto(_ bounds:CGSize?) -> UIImage {
        if bounds == nil {
            return self
        }
        
        var scaledSize:CGSize = bounds!
        
        let ratioX = bounds!.width / self.size.width
        let ratioY = bounds!.height / self.size.height
        let useRatio = min(ratioX, ratioY)
        
        scaledSize.width = self.size.width * useRatio
        scaledSize.height = self.size.height * useRatio
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        let scaledImageRect = CGRect(x: 0.0, y: 0.0, width: scaledSize.width, height: scaledSize.height)
        self.draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

extension UILabel
{
    func setFrame(_ x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) {
        self.frame = self.frame
    }
}

extension String
{
    func toHumanFriendlyUrl() -> String {
        if self.count == 0 {
            return ""
        }
        let url = splitOn(first:"://").last!
        return url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }

    var titleCase:String {
        return String(self[0]).uppercased() + self[1..<self.count]
    }
    
    var count:Int {
        return self.characters.count
    }
}

extension NSDictionary
{
    func getItem(_ key:String) -> Any? {
        return self[String(key[0]).lowercased() + key[1..<key.count]]
            ?? self[String(key[0]).uppercased() + key[1..<key.count]]
    }
}

extension UIColor {
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.characters.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    var isDark:Bool {
        let componentColors = self.cgColor.components
        let r = ((componentColors?[0])! * 299)
        let g = ((componentColors?[1])! * 587)
        let b = ((componentColors?[2])! * 114)
        let colorBrightness = (r + g + b) / 1000
        return colorBrightness < 0.5
    }
    
    var isLight:Bool { return !self.isDark }
}


