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
    let otpView: OTPView = {
        let view = OTPView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    @IBAction func submitOtp(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(otpView)
        
        NSLayoutConstraint.activate([
            otpView.heightAnchor.constraint(equalToConstant: 50),
            otpView.widthAnchor.constraint(equalToConstant: 200),
            otpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            otpView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        otpView.configureView(focus: UIColor.blue.cgColor,
                              normal: UIColor.lightGray.cgColor,
                              otpCount: 4)
        otpView.getOtp = { otp, valid in
            print(otp, valid)
        }
    }
}

