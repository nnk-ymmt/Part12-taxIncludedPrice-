//
//  ViewController.swift
//  Part12-taxIncludedPrice-
//
//  Created by 山本ののか on 2020/12/31.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var taxExcludedPriceTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let taxRate = UserDefaults.standard.integer(forKey: "taxRate")
        taxRateTextField.text = String(taxRate)
    }

    @IBAction private func calculate(_ sender: Any) {
        guard let taxExcludedPrice = Int(taxExcludedPriceTextField.text ?? ""),
           let taxRate = Float(taxRateTextField.text ?? "") else {
            return
        }
        let taxIncludedPrice = Int(Float(taxExcludedPrice) * ( 1 + taxRate / 100))
        taxIncludedPriceLabel.text = String(taxIncludedPrice)
        UserDefaults.standard.set(taxRate, forKey: "taxRate")
    }
}
