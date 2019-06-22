//
//  ViewController.swift
//  AnimateTFD
//
//  Created by umit1989dnz on 06/16/2019.
//  Copyright (c) 2019 umit1989dnz. All rights reserved.
//

import UIKit
import AnimateTFD

class ViewController: UIViewController {

    @IBOutlet weak var tfdUserName: AnimatedTFD!
    @IBOutlet weak var tfdEmail: AnimatedTFD!
    @IBOutlet weak var tfdPassword: AnimatedTFD!
    @IBOutlet weak var tfdPhoneNumber: AnimatedTFD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "animatedTFD"
        
        //config textfield
        self.tfdEmail.titleTextColor = UIColor.red.withAlphaComponent(0.5)//set color for animated title
        self.tfdEmail.addBottomLine(lineColor: UIColor.brown)// add bottom line with color inside textfield

        self.startType()

    }

    private func startType()  {
        var counter = 0
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
                switch counter {
                case 0 :
                    self.tfdEmail.becomeFirstResponder()
                    AutoType.autoType(tfd: self.tfdEmail, text: "umit1989dnz@gmail.com")
                case 1 :
                    self.tfdUserName.becomeFirstResponder()
                    AutoType.autoType(tfd: self.tfdUserName, text: "umit")
                case 2 :
                    self.tfdPassword.becomeFirstResponder()
                    AutoType.autoType(tfd: self.tfdPassword, text: "123456")
                case 3 :
                    self.tfdPhoneNumber.becomeFirstResponder()
                    AutoType.autoType(tfd: self.tfdPhoneNumber, text: "+989388156262")
                default:
                    break
                }
                
                if counter == 3 {
                    timer.invalidate()
                } else {
                    counter += 1
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

