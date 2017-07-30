
import Foundation
import UIKit
import CoreLocation
class BasicFunctions: NSObject {
    
    class func colorForHax(_ rgba:String)->UIColor{
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
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                    break
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                    break
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                    break
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                    break
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                    break
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func setPreferences(_ value:Any!, key:String) {
        let defaults : UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    class func setDeviceToken(_ value:Any!, key:String) {
        let defaults : UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    class func getPreferences(_ key:String!) -> Any! {
        let defaults : UserDefaults = UserDefaults.standard
        return defaults.object(forKey: key) as Any!
    }
    
    class func removePreferences(_ key:String!){
        let userDefault:UserDefaults = UserDefaults.standard
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }
    
    class func setBoolPreferences(_ val:Bool,forkey key:String!){
        let userDefault:UserDefaults = UserDefaults.standard
        userDefault.set(val, forKey: key)
        userDefault.synchronize()
    }
    
    class func getBoolPreferences(_ key:String!) -> Bool {
        let userDefault:UserDefaults = UserDefaults.standard
        return userDefault.bool(forKey: key)
    }
    
    class func maskImage(_ originalImage:UIImage!, maskImage:UIImage!) -> UIImage! {
        
        let mask : CGImage = CGImage(maskWidth: originalImage.cgImage!.width,
            height: originalImage.cgImage!.height,
            bitsPerComponent: originalImage.cgImage!.bitsPerComponent,
            bitsPerPixel: originalImage.cgImage!.bitsPerPixel,
            bytesPerRow: originalImage.cgImage!.bytesPerRow,
            provider: originalImage.cgImage!.dataProvider!, decode: nil, shouldInterpolate: true)!
        
        let maskedImageRef : CGImage = maskImage.cgImage!.masking(mask)!
        let finalImage : UIImage? = UIImage(cgImage: maskedImageRef)
        
        return finalImage
        
    }
    
    class func imageWithColor(_ color1: UIColor, img: UIImage) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: img.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height) as CGRect
        context.clip(to: rect, mask: img.cgImage!)
        color1.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    class func imageFromColor(_ color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    class func heightOfLabelWithWidth(_ titleText : NSString, font : UIFont, width : CGFloat) -> CGFloat{
        
        let maxSize : CGSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let labelRect : CGRect = titleText.boundingRect(with: maxSize, options: ([NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading]), attributes: [NSFontAttributeName:font], context: nil)
        return labelRect.size.height
        
    }
    
    class func getProperSize(_ image:UIImage!,withWidth width:CGFloat,withHeight height:(CGFloat)) -> UIImage {
        
        var newSize:CGSize = CGSize(width: width, height: height)
        let widthRatio:CGFloat = newSize.width/image.size.width
        let heightRatio:CGFloat = newSize.height/image.size.height;
        
        if(widthRatio > heightRatio){
            newSize = CGSize(width: image.size.width*widthRatio,height: image.size.height*widthRatio)
            
        }else{
            newSize=CGSize(width: image.size.width*heightRatio,height: image.size.height*heightRatio)
        }
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //MARK: Convert Obj to Dict
//    class func Object_TO_Dict(_ obj:AnyObject)->NSMutableDictionary{
//        
//        var propertiesCount : CUnsignedInt = 0
//        let propertiesInAClass : UnsafeMutablePointer<Category> = class_copyPropertyList(obj.classForCoder, &propertiesCount)
//        let propertiesDictionary : NSMutableDictionary = NSMutableDictionary()
//        
//        for i in 0 ..< Int(propertiesCount) {
//            let strKey : NSString? = NSString(cString: property_getName(propertiesInAClass[i]), encoding: String.Encoding.utf8.rawValue)
//            propertiesDictionary.setValue(obj.value(forKey: strKey! as String), forKey: strKey! as String)
//        }
//        
////        for var i = 0; i < Int(propertiesCount); i++ {
////            let strKey : NSString? = NSString(CString: property_getName(propertiesInAClass[i]), encoding: NSUTF8StringEncoding)
////            propertiesDictionary.setValue(obj.valueForKey(strKey! as String), forKey: strKey! as String)
////        }
//        return propertiesDictionary
//    }
    
    
    //MARK: Convert Dict to Obj
    class func Dict_to_object(_ dict:Dictionary<String,AnyObject?>,obj:AnyObject)->AnyObject  {
        for (key, value) in dict {
            
            if (obj.responds(to: NSSelectorFromString(key))) {
                obj.setValue(value, forKey: key)
            }
        }
        return obj
    }
    
    //MARK: Global Dialog display mentod
    class func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = APP_NAME)  {
        
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                UIViewController.currentViewController()!.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        
        UIViewController.currentViewController()!.present(alertController, animated: true, completion: nil)
    }
    
    class func contains(_ text: String, substring: String,
                        ignoreCase: Bool = true,
                        ignoreDiacritic: Bool = true) -> Bool {
        
        var options = NSString.CompareOptions()
        
        if ignoreCase { _ = options.insert(NSString.CompareOptions.caseInsensitive) }
        if ignoreDiacritic { _ = options.insert(NSString.CompareOptions.diacriticInsensitive) }
        
        return text.range(of: substring, options: options) != nil
    }
    
    class func hitApi( latitude : Double , longitude : Double) -> Bool
    {
        if !userLoggedIn()
        {
            return false
        }
        let stringLatitutde = String(latitude)
        let stringLongitude = String(longitude)
        
        let previousLatitude = getPreferences(USER_LATITUDE)
        let previousLongitude = getPreferences(USER_LONGITUDE)

        if previousLatitude == nil {
            setPreferences(stringLatitutde, key: USER_LATITUDE)
            setPreferences(stringLongitude, key: USER_LONGITUDE)
            let minutes : Int = convertTimeToMinutes()
            setPreferences(String(minutes), key: USER_LOCATION_UPDATED_ON)
            return true
        }
        
        let previousLatitudeDouble = (previousLatitude as! NSString).doubleValue
        let previousLongitudeDouble = (previousLongitude as! NSString).doubleValue
        
        
        let oldCoordinate = CLLocation(latitude:previousLatitudeDouble, longitude:previousLongitudeDouble)
        let newCordinate = CLLocation(latitude: latitude, longitude: longitude)
        
        let distanceInMeters = oldCoordinate.distance(from: newCordinate) // result is in meters
        if distanceInMeters > 50 {
            setPreferences(stringLatitutde, key: USER_LATITUDE)
            setPreferences(stringLongitude, key: USER_LONGITUDE)
            let minutes : Int = convertTimeToMinutes()
            setPreferences(String(minutes), key: USER_LOCATION_UPDATED_ON)

            return true

        }
        else
        {
        
            if updateOntheBasisOfTime() {
                setPreferences(stringLatitutde, key: USER_LATITUDE)
                setPreferences(stringLongitude, key: USER_LONGITUDE)
                let minutes : Int = convertTimeToMinutes()
                setPreferences(String(minutes), key: USER_LOCATION_UPDATED_ON)
                
                return true

                
            }
            else
            {
            return false
            }
        }

        
        
        
        
    }
    
    class func updateOntheBasisOfTime()->Bool
    {
        let last = getPreferences(USER_LOCATION_UPDATED_ON) as! String
        let lastTime = (last as NSString).integerValue as Int
        let currentTime = convertTimeToMinutes() as Int
        if abs(currentTime-lastTime) >= 60
        {
            return true;
        }
        else
        {
            return false
        }
    }
    class func convertTimeToMinutes() -> Int
    {
        
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: NSDate() as Date)
        let minute = calendar.component(.minute, from: NSDate() as Date)
        
        //
        var timeInMinutes = minute + (hour * 60)
        //
        return timeInMinutes
    }
    
    class func userLoggedIn() -> Bool
    {
        let data = BasicFunctions.getPreferences(PRE_USER_INFO)
        if (data == nil)
        {
            return false;
        }
        else
        
        {
            return true
        }

        
    }
    class func convertMinutesToHours(minutes : Int) -> String{
        if minutes>=0
        {
        let hours:Int = minutes/60
        let mins:Int = minutes%60
            let strTimestamp:String =  String(hours) + "h" + ":" + String(mins) + "m" + "ago"
            return strTimestamp
        }
        
        else
        {
            let time : Int = abs(minutes) as Int
            let hours:Int = time/60
            let mins:Int = time%60
            let strTimestamp:String =  String(hours) + "h" + ":" + String(mins) + "m" + " later"
            return strTimestamp

        }

    }

}
