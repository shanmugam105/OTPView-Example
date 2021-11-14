//
//  OTPView.swift
//  OTPView-Example
//
//  Created by ADMIN on 05/08/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

public final class NCOTPView: UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public var getOtp: ((_ otp: String, _ valid: Bool) -> Void)?
    private var focusColor: CGColor = UIColor.yellow.cgColor
    private var normalColor: CGColor = UIColor.lightGray.cgColor
    
    public func configureView(focus color1: CGColor,
                              normal color2: CGColor,
                              backgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.1),
                              otpCount: Int,
                              secure: Bool = false) {
        addSubview(stackView)
        focusColor = color1
        normalColor = color2
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        for tag in 0...otpCount - 1 {
            let textField: UITextField = {
                let texfield = UITextField()
                texfield.tag = tag
                texfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
                texfield.keyboardType = .numberPad
                texfield.textAlignment = .center
                texfield.isSecureTextEntry = secure
                texfield.delegate = self
                texfield.layer.borderWidth = 1
                texfield.layer.borderColor = normalColor
                texfield.layer.cornerRadius = 4
                texfield.translatesAutoresizingMaskIntoConstraints = false
                texfield.textColor = .black
                texfield.backgroundColor = backgroundColor
                texfield.tintColor = .clear
                return texfield
            }()
            addDoneButtonOnKeyboard(for: textField)
            NSLayoutConstraint.activate([textField.widthAnchor.constraint(equalToConstant: frame.height)])
            stackView.addArrangedSubview(textField)
        }
    }
}

extension NCOTPView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        stackView.arrangedSubviews.forEach {
            guard let newTextField = $0 as? UITextField else { return }
            newTextField.tag == textField.tag ? (newTextField.layer.borderColor = focusColor):(newTextField.layer.borderColor = normalColor)
        }
        textField.selectAll(self)
    }

    private func otpEndAction() {
        var otpString = ""
        stackView.arrangedSubviews.forEach {
            guard
                let newTextField = $0 as? UITextField,
                let text = newTextField.text
            else { return }
            otpString += text
        }
        getOtp?(otpString, otpString.count == stackView.arrangedSubviews.count)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        stackView.arrangedSubviews.forEach {
            if let newTextField = $0 as? UITextField {
                if textField.text == "" {
                    if newTextField.tag == textField.tag - 1 {
                        newTextField.becomeFirstResponder()
                    }
                }else{
                    if newTextField.tag == textField.tag + 1 {
                        newTextField.becomeFirstResponder()
                    }
                }
            }
        }
        if textField.tag + 1 == stackView.arrangedSubviews.count && textField.text != "" {
            textField.layer.borderColor = normalColor
            endEditing(true)
        }
        otpEndAction()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) == nil && string != "" { return false }
        if string.count == 1 {
            return range.location == 0
        } else if string.count == stackView.arrangedSubviews.count {
            for item in stackView.arrangedSubviews {
                guard let newTextField = item as? UITextField else { return false }
                newTextField.text = string.map{String($0)}[item.tag]
                newTextField.layer.borderColor = normalColor
            }
            endEditing(true)
        } else if string == "" {
            return true
        }
        return false
    }
}

extension NCOTPView {
    func addDoneButtonOnKeyboard(for textField: UITextField){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    @objc func hideKeyboard(){ endEditing(true) }
}
