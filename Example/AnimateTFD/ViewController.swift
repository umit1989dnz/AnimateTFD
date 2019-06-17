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

    
    @IBOutlet weak var tfd: AnimatedTFD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tfd.addIcon(iconTextType: AnimatedTFD.inputType.Email)
        tfd.IconColorChanged = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

