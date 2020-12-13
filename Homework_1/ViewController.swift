//
//  ViewController.swift
//  Homework_1
//
//  Created by Aliona Starunska on 09.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var recursionResultLabel: UILabel!
    @IBOutlet private weak var iterationResultLabel: UILabel!
    @IBOutlet private weak var inputTextFieldTask2: UITextField!
    @IBOutlet private weak var inputTextFieldTask3: UITextField!
    @IBOutlet private weak var fibonaciRecursionResult: UILabel!
    @IBOutlet private weak var fibonaciIterationResult: UILabel!
    @IBOutlet private weak var task3ResultLabel: UILabel!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustingHeight(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    func adjustingHeight(_ show: Bool, notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo,
              let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.0
        let changeInHeight = show ? keyboardFrame.height : 0.0
        guard bottomConstraint.constant != changeInHeight else { return }
        bottomConstraint.constant = changeInHeight
        UIView.animate(withDuration: animationDurarion, animations: { [unowned self] () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == inputTextField {
            let n = inputTextField.intText
            if n < 20 {
                recursionResultLabel.text = "\(n.factorialRecursive)"
                iterationResultLabel.text = "\(n.factorialIterative)"
            } else {
                recursionResultLabel.text = "Calculation overflow"
                iterationResultLabel.text = "Calculation overflow"
            }
        }
        if textField == inputTextFieldTask2 {
            let n2 = inputTextFieldTask2.intText
            if n2 < 47 {
                fibonaciRecursionResult.text = "\(n2.fibonaciRecursive)"
                fibonaciIterationResult.text = "\(n2.fibonaciIterative)"
            } else {
                fibonaciRecursionResult.text = "Calculation overflow"
                fibonaciIterationResult.text = "Calculation overflow"
            }
        }
        if textField == inputTextFieldTask3 {
            let n3 = inputTextFieldTask3.intText
            task3ResultLabel.text = "\(n3.numberOfPi)"
        }
        return true
    }
}

// MARK: - Task 1

extension Int64 {
    var factorialRecursive: Int64 {
        guard self >= 0 else { return 0 }
        guard self < 20 else { return Int64.max }
        guard self > 1 else { return 1 }
        return self * (self - 1).factorialRecursive
    }
    
    var factorialIterative: Int64 {
        guard self >= 0 else { return 0 }
        guard self < 20 else { return Int64.max }
        var result: Int64 = 1
        if self > 2 {
            for i in 2...self {
                result *= i
            }
        }
        return result
    }
}

// MARK: - Task 2

extension UITextField {
    var intText: Int64 {
        return Int64(text ?? "") ?? 0
    }
}

// MARK: - Task 3

extension Int64 {
    var fibonaciRecursive: Int64 {
        guard self >= 0 else { return 0}
        guard self < 47 else { return .max }
        guard self != 0, self != 1 else { return 1 }
        return (self - 1).fibonaciRecursive + (self - 2).fibonaciRecursive
    }
    
    var fibonaciIterative: Int64 {
        guard self >= 0 else { return 0}
        guard self < 47 else { return .max }
        guard self != 0, self != 1 else { return 1 }
        var oldValue: Int64 = 0
        var value: Int64  = 1
        var hold: Int64 = 0
        for _ in 1...self {
            hold = value
            value += oldValue;
            oldValue = hold
        }
        return value
    }
}

extension Int64 {
    var numberOfPi: Int64 {
        return Int64((Double.pi * pow(10, Double(self + 1))).truncatingRemainder(dividingBy: 10))
    }
}
