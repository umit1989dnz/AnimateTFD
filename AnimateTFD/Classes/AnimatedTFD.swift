import UIKit
import Foundation

open class AnimatedTFD: UITextField {
    
    public enum inputType {
        case Email
        case UserName
        case Password
        case phoneNumber
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
        
        self.addSubview(placeholders)
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0)])
        
        self.placeholders.text = self.placeholder
        self.placeholders.font = UIFont.systemFont(ofSize: 13)
        self.placeholders.sizeToFit()
        
        self.placeholders.textColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.placeholders.translatesAutoresizingMaskIntoConstraints = false
        
        self.placeholders.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.placeholders.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.placeholders.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
    }
    
    public init() {
        super.init(frame: .zero)
        delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    private let border = CALayer(),
    icon = UILabel(),
    validateIcon = UILabel(),
    bottomLine = UIView()
    
    private var placeholders = UILabel(),
    IconColorChanged = false,
    textType = inputType.UserName
    
    public var parentView = UIView(),
    titleTextColor = UIColor.brown.withAlphaComponent(0.5),
    titleFonts = UIFont.systemFont(ofSize: 9)
    
    func createBorder(){
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 55/255, green: 78/255, blue: 95/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func removeBorder(){
        border.removeFromSuperlayer()
    }
    
    public func addBottomLine(lineColor:UIColor) {
        
        self.addSubview(self.bottomLine)
        
        self.bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomLine.heightAnchor.constraint(lessThanOrEqualToConstant: 1).isActive = true
        self.bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        self.bottomLine.backgroundColor = lineColor
    }
    
    
    private func handlePlaceHolder(isShow:Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.placeholders.textColor = isShow ? UIColor.lightGray.withAlphaComponent(0.5) : self.titleTextColor.withAlphaComponent(0.9)
            self.placeholders.font = isShow ? self.titleFonts.withSize(13) : self.titleFonts.withSize(9)
            self.placeholders.transform = isShow ? CGAffineTransform(translationX: 0, y: 0) : CGAffineTransform(translationX: 0, y: -20)
            self.placeholders.layoutIfNeeded()
        }) { (success) in
            
        }
        
    }
    
    private func handleTitleText(isShow:Bool) {
        self.placeholders.textColor = isShow ? UIColor.lightGray.withAlphaComponent(0.5) : self.titleTextColor.withAlphaComponent(0.9)
    }
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    var leftPadding:CGFloat = 5
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 5))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 5))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 5))
    }
    
    @objc private func textFieldDidChange(sender:UITextField) {
        if sender.text!.count > 0 {
            UIView.animate(withDuration: 2) {
                self.icon.textColor = .red
                self.handleTitleText(isShow: false)
            }
        } else {
            UIView.animate(withDuration: 2) {
                self.icon.textColor = .lightGray
                self.handleTitleText(isShow: true)
            }
        }
        
        if self.textType == .Email {
            if  self.isValidEmail(testStr: sender.text!) == true {
                UIView.animate(withDuration: 0.5) {
                    self.validateIcon.transform = CGAffineTransform(translationX: +50, y: 0)
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.validateIcon.transform = .identity
                }
            }
            
            if sender.text?.count == 0 {
                UIView.animate(withDuration: 0.5) {
                    self.validateIcon.transform = CGAffineTransform(translationX: +50, y: 0)
                }
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}

extension AnimatedTFD:UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.handlePlaceHolder(isShow: false)
        self.placeholders.textColor = self.IconColorChanged ? UIColor.red : UIColor.lightGray.withAlphaComponent(0.5)
        if self.text?.count == 0 {
            self.handleTitleText(isShow: true)
        } else {
            self.handleTitleText(isShow: false)
        }
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if self.text?.count == 0 {
            self.handlePlaceHolder(isShow: true)
            self.handleTitleText(isShow: true)
            
        } else {
            self.handleTitleText(isShow: false)
        }
    }
    
}
