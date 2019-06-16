
import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIImage{
    
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
}
extension String {
    
    func toBase64() ->String  {
        let utf8str = self.data(using: String.Encoding.utf8)
        var str = ""
        if let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
        {
            str =  base64Encoded
        }
        print(str)
        return str
    }
    func fromBase64() -> String {
        var str = ""
        if let base64Decoded = NSData(base64Encoded: self, options:   NSData.Base64DecodingOptions(rawValue: 0))
            .map({ NSString(data: $0 as Data, encoding: String.Encoding.utf8.rawValue) })
        {
            // Convert back to a string
            str = base64Decoded! as String
        }
        print(str)
        return str
    }
    
}
extension String {
    func ks_size(of font: UIFont, maxWidth: CGFloat) -> CGSize {
        let s = self as NSString
        let size = s.boundingRect(with: CGSize(width: maxWidth, height: .infinity), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil).size
        return size;
    }
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

extension UINavigationController {
    func popToViewController<T: UIViewController>(withType type: T.Type) {
        for viewController in self.viewControllers {
            if viewController is T {
                self.popToViewController(viewController, animated: true)
                return
            }
        }
    }
}
extension String{
    func convert() -> String
    {
        var finalStr:String = ""
        for a in self.unicodeScalars
        {
            print(self.unicodeScalars)
            
            switch(a.value)
            {
            case "۱".unicodeScalars["۱".unicodeScalars.startIndex].value, 1633:
                
                finalStr = finalStr.appending("1")
                break
                
            case "۲".unicodeScalars["۲".unicodeScalars.startIndex].value, 1634:
                
                finalStr = finalStr.appending("2")
                break
                
            case "۳".unicodeScalars["۳".unicodeScalars.startIndex].value, 1635:
                
                finalStr = finalStr.appending("3")
                break
                
                
            case "۴".unicodeScalars["۴".unicodeScalars.startIndex].value, 1636:
                
                finalStr = finalStr.appending("4")
                break
                
                
            case "۵".unicodeScalars["۵".unicodeScalars.startIndex].value, 1637:
                
                finalStr = finalStr.appending("5")
                break
                
            case "۶".unicodeScalars["۶".unicodeScalars.startIndex].value, 1638:
                
                finalStr = finalStr.appending("6")
                break
                
            case "۷".unicodeScalars["۷".unicodeScalars.startIndex].value, 1639:
                finalStr = finalStr.appending("7")
                break
                
                
            case "۸".unicodeScalars["۸".unicodeScalars.startIndex].value, 1640:
                finalStr = finalStr.appending("8")
                break
                
            case "۹".unicodeScalars["۹".unicodeScalars.startIndex].value, 1641:
                finalStr = finalStr.appending("9")
                break
                
            case "۰".unicodeScalars["۰".unicodeScalars.startIndex].value, 1632:
                finalStr = finalStr.appending("0")
                break
            case 1610, 1574, 1609:
                finalStr = finalStr.appending("ی")
                break
            case 1603:
                finalStr = finalStr.appending("ک")
                break
            default:
                finalStr = finalStr.appending("\(a)")
                break
            }
        }
        return finalStr
    }
}

extension UIColor {
    public convenience init?(AddHexString: String) {
        let r, g, b, a: CGFloat
        
        if AddHexString.hasPrefix("#") {
            let start = AddHexString.index(AddHexString.startIndex, offsetBy: 1)
            let hexColor = String(AddHexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
extension String {
    func addCommaToMyAmounts() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        let amount = Int(self)
        let formaterString = formatter.string(for: amount)
        return formaterString!
    }
}


extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

