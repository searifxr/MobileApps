//
//  ViewController.swift
//  TipCalculator
//
//  Created by Pothapragada, Krishna N on 10/27/25.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import Network


class ViewController: UIViewController {

    @IBOutlet weak var inputBill: UITextField!
    @IBOutlet weak var otherTipField: UITextField!
    @IBOutlet weak var segmentedTip: UISegmentedControl!
    @IBOutlet weak var otherTipStack: UIStackView!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var promiseTipButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var ActivityTimeWaste: UIActivityIndicatorView!
    
    @IBOutlet weak var tdyifuoyuguv: UIStackView!
    @IBOutlet weak var EmojiFreaky: UILabel!
    
    var tipPercentage: Double = 0.15

    override func viewDidLoad() {
        super.viewDidLoad()
        otherTipStack.isHidden = true
        promiseTipButton.isHidden = true
        messageLabel.isHidden = true
        ActivityTimeWaste.isHidden = true
        setupTargets()
        calculateTipAmount()
    }
    

    func getWiFiAddress() -> String? {
        var address: String?

        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name = String(cString: interface.ifa_name)
                if name == "en0" { // Wi-Fi interface
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }

        freeifaddrs(ifaddr)
        return address
    }


    
    func setupTargets() {
        inputBill.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        otherTipField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    // MARK: - Tip Segments
    @IBAction func tipSelectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            otherTipStack.isHidden = true
            tipPercentage = 0.15
        case 1:
            otherTipStack.isHidden = true
            tipPercentage = 0.18
        case 2:
            otherTipStack.isHidden = true
            tipPercentage = 0.20
        case 3:
            otherTipStack.isHidden = false
            tipPercentage = (Double(otherTipField.text ?? "") ?? 15.0) / 100.0
        default:
            tipPercentage = 0.15
        }
        calculateTipAmount()
    }

    @objc func textFieldDidChange() {
        if segmentedTip.selectedSegmentIndex == 3 {
            tipPercentage = (Double(otherTipField.text ?? "") ?? 15.0) / 100.0
        }
        calculateTipAmount()
    }


    func calculateTipAmount() {
        let bill = Double(inputBill.text ?? "") ?? 0.0
        let tipAmount = bill * tipPercentage
        let total = bill + tipAmount

        tipAmountLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", total)
    }


    @IBAction func Reset(_ sender: Any) {

        let alert = UIAlertController(
            title: "Brochanco, can I ask a question?",
            message: "Please select a tipping amount for your service in using the app",
            preferredStyle: .alert
        )


        alert.addAction(UIAlertAction(title: "120%", style: .default, handler: {_ in self.resetEverything()}))
        alert.addAction(UIAlertAction(title: "500%", style: .default, handler: {_ in self.resetEverything()}))
        alert.addAction(UIAlertAction(title: "1000%", style: .default, handler: {_ in self.resetEverything()}))
        
        
        alert.addAction(UIAlertAction(title: "GETYOOOO", style: .destructive, handler: { _ in

            self.ActivityTimeWaste.startAnimating()
            self.ActivityTimeWaste.isHidden = false
            self.backgroundView.backgroundColor = .black
            self.backgroundView.alpha = 0.6

            self.tdyifuoyuguv.isHidden = true
            self.messageLabel.isHidden = true
            self.promiseTipButton.isHidden = true
            self.EmojiFreaky.isHidden = true
            self.resetButton.isHidden = true
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // Stop loading
                self.ActivityTimeWaste.stopAnimating()
                self.ActivityTimeWaste.isHidden = true
                self.backgroundView.alpha = 1.0

                // Show UI
                self.promiseTipButton.isHidden = false
                self.messageLabel.isHidden = false
                self.messageLabel.textColor = .white

                let ip = self.getWiFiAddress() ?? "You lucky I can't find yo IP"
                self.messageLabel.text = "\(ip) Does this sound familiar?"

                self.EmojiFreaky.isHidden = false
                self.EmojiFreaky.textColor = .white
                self.EmojiFreaky.text = "∮👿🀃⏅☢︎☠︎☠︎☠︎"
            }
        }))


  
        self.present(alert, animated: true)
    }



    func resetEverything() {
        inputBill.text = ""
        otherTipField.text = ""
        tipPercentage = 0.15
        segmentedTip.selectedSegmentIndex = 0
        backgroundView.backgroundColor = .systemPink
        promiseTipButton.isHidden = true
        messageLabel.isHidden = true
        tdyifuoyuguv.isHidden = false
        calculateTipAmount()
    }


    @IBAction func PromiseToTip(_ sender: Any) {
        let alert = UIAlertController(
            title: "Good boy",
            message: "For that ur tipping 𝕵𝖆𝖞𝖉𝖊𝖓'𝖘 𝖇𝖚𝖘",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "𝕥𝕤 𝕤𝕠 𝕟𝕚𝕔𝕙𝕖🥹", style: .default, handler: { _ in
            self.resetEverything()
            self.EmojiFreaky.text = "🤑🤑"
        }))
        self.present(alert, animated: true)
    }
    
}
