//
//  ViewController.swift
//  Part12-taxIncludedPrice-
//
//  Created by 山本ののか on 2020/12/31.
//

import UIKit

/// 税率の保存・読み込みに関する能力を規定する
protocol TaxRateRepositoryProtocol {
    func load() -> Float
    func save(taxRate: Float)
}

final class ViewController: UIViewController {

    @IBOutlet private weak var taxExcludedPriceTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!

    // ViewController は具体的な型に依存させず、TaxRateRepositoryProtocolに依存させる
//    private let taxRateRepository: TaxRateRepositoryProtocol = TaxRateRepository()
    private let taxRateRepository: TaxRateRepositoryProtocol = FakeTaxRateRepository(taxRate: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taxRate = taxRateRepository.load()
        taxRateTextField.text = String(taxRate)
    }

    @IBAction private func calculate(_ sender: Any) {
        guard let taxExcludedPrice = Int(taxExcludedPriceTextField.text ?? ""),
              let taxRate = Float(taxRateTextField.text ?? "") else {
            return
        }
        
        let taxIncludedPrice = Int(Float(taxExcludedPrice) * ( 1 + taxRate / 100))
        taxIncludedPriceLabel.text = String(taxIncludedPrice)

        taxRateRepository.save(taxRate: taxRate)
    }
}

struct TaxRateRepository: TaxRateRepositoryProtocol {
    private let key = "taxRate"
    
    func load() -> Float {
        return UserDefaults.standard.float(forKey: key)
    }
    
    func save(taxRate: Float) {
        UserDefaults.standard.set(taxRate, forKey: key)
    }
}

/// 特定の税率が保存されている時の挙動をテストしたい時に使う
class FakeTaxRateRepository: TaxRateRepositoryProtocol {
    private var taxRate: Float
    
    init(taxRate: Float) {
        self.taxRate = taxRate
    }
    
    func load() -> Float { return taxRate }
    func save(taxRate: Float) { self.taxRate = taxRate }
}
