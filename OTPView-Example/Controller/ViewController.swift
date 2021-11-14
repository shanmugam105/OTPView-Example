//
//  ViewController.swift
//  OTPView-Example
//
//  Created by ADMIN on 05/08/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import NCOTPView

class ViewController: UIViewController {
    @IBOutlet weak var otpView1: NCOTPView!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitOtp(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        otpView1.configureView(focus: UIColor.blue.cgColor,
                              normal: UIColor.lightGray.cgColor,
                              backgroundColor: .blue.withAlphaComponent(0.1),
                              otpCount: 4,
                              secure: false)
        otpView1.getOtp = { otp, valid in
            print(otp, valid)
            self.submitButton.isHidden = !valid
        }
    }
}

