//
//  CustomTextField.swift
//  RTL
//
//  Created by omid on 6/14/19.
//  Copyright © 2019 omid pourpanah. All rights reserved.
//

import UIKit
import Foundation

class AnimatedTFD: UITextField, UITextFieldDelegate {
    
    enum inputType {
        case Email
        case UserName
        case Password
        case phoneNumber
    }
    
    private func icomoon(size:CGFloat) -> UIFont {
        return UIFont(name: "icomoon", size: size)!
    }
    
    private func materialDesign(size:CGFloat) -> UIFont {
        return UIFont(name: "Material-Design-Icons", size: size)!
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    private let border = CALayer()
    private let icon = UILabel()
    private let validateIcon = UILabel()
    
    var IconColorChanged = false
    var textType = inputType.UserName
    
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
    
    func addIcon(iconTextType:inputType)  {
        
        self.clipsToBounds = true
        
        self.addSubview(icon)
        
        self.icon.font = self.materialDesign(size: 25)
        self.icon.textAlignment = .center
        
        self.textType = iconTextType
        
        switch iconTextType {
        case .Email:
            self.icon.text = ""
            self.keyboardType = .emailAddress
            break
        case .UserName:
            self.icon.text = ""
            self.keyboardType = .default
            break
        case .Password:
            self.icon.text = ""
            self.keyboardType = .default
            self.isSecureTextEntry = true
            break
        case .phoneNumber:
            self.icon.text = ""
            self.keyboardType = .phonePad
            break
        default:
            break
        }
        
        self.icon.textColor = .lightGray
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.icon.transform = CGAffineTransform(translationX: -50, y: 0)
        
        if iconTextType == .Email {
            self.addValidateIcon(iconTextType: iconTextType)
            
        }
    }
    
    private func addValidateIcon(iconTextType:inputType) {
        
        self.addSubview(self.validateIcon)
        
        self.validateIcon.font = self.materialDesign(size: 22)
        self.validateIcon.textAlignment = .center
        
        self.textType = iconTextType
        
        self.validateIcon.text = ""
        
        self.validateIcon.textColor = .red
        self.validateIcon.translatesAutoresizingMaskIntoConstraints = false
        
        validateIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        validateIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        validateIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        validateIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.validateIcon.transform = CGAffineTransform(translationX: +50, y: 0)
        
    }
    
    private func handleIcon(isShow:Bool) {
        UIView.animate(withDuration: 0.2) {
            self.icon.transform = isShow ? CGAffineTransform(translationX: 0, y: 0) : CGAffineTransform(translationX: -50, y: 0)
            self.icon.layoutIfNeeded()
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    @objc private func textFieldDidChange(sender:UITextField) {
        if sender.text!.count > 0 {
            UIView.animate(withDuration: 2) {
                self.icon.textColor = .red
                
            }
        } else {
            UIView.animate(withDuration: 2) {
                self.icon.textColor = .lightGray
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
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("focused")
        self.handleIcon(isShow: true)
        self.icon.textColor = self.IconColorChanged ? UIColor.red : UIColor.lightGray
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.removeBorder()
        
        if self.text?.count == 0 {
            self.handleIcon(isShow: false)
            self.icon.textColor = self.IconColorChanged ? UIColor.lightGray : UIColor.lightGray
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
