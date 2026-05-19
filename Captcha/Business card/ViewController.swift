//
//  ViewController.swift
//  Business card
//
//  Created by Pothapragada, Krishna N on 8/28/25.
//

import UIKit

class ViewController: UIViewController {
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
//    var lblHorizontal = UILabel(
//    var lblVertical = UILabel()
    
    var pic = UIImageView()
    
    let Name = UILabel()
    let Desc = UILabel()
    let btn = UIButton()
    var phoneNumber = UILabel()
    var Email = UILabel()
    
    
    var toggle = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = (screenBounds.width)
        screenHeight = (screenBounds.height)
        
        self.view.backgroundColor = .darkGray
        
        
        print("Screen width: \(screenWidth), Screen Height \(screenHeight)")
        
//        lblHorizontal.frame = CGRect(x: 20, y: 100, width: screenWidth - 40, height: 50)
//        lblHorizontal.backgroundColor = UIColor.blue
//        lblHorizontal.text = "Screen width: \(screenWidth), Label width: \(screenWidth - 40)"
//        
//        view.addSubview(lblHorizontal)
//        
//        lblVertical.frame = CGRect(x: 50, y: 20, width: 50, height: screenHeight)
//        lblVertical.backgroundColor = UIColor.red
//        lblVertical.text = "Screen Hieght: \(screenHeight), Label Height: \(screenHeight-40)"
//
//        
//      lblHorizontal.frame = CGRect(x: 20, y: 100, width: 50, height: screenWidth - 40)
//        
//        view.addSubview(lblVertical)
        
        //874, 402 <-- Screeb dimensions
        PFP()
        setUpLabeles()
        setUpButton()
        setUpContactLabel()
        
    
        
       
        }
    @objc
    func showContactInfo(_ sender: UIButton!){
        
        Email.isHidden.toggle()
        phoneNumber.isHidden.toggle()
        toggle.toggle()
        if(toggle){
            btn.setTitle("Tap to show contact info", for: .normal)
    
        }
        else{
            btn.setTitle("Tap to hide contact info", for: .normal)
            
//            let phoneNumber = UILabel( frame: CGRect(x: center_x, y: center_y, width: 250, height: 35))
//            phoneNumber.layer.cornerRadius = 10
//            phoneNumber.layer.masksToBounds = true
//            phoneNumber.backgroundColor = .white
//            phoneNumber.text = "112-990-7882"
//            phoneNumber.textColor = .systemBlue
//            phoneNumber.textAlignment = .center
//            let Email = UILabel( frame: CGRect(x: 85, y: 650, width: 250, height: 35))
//            Email.layer.cornerRadius = 10
//            Email.layer.masksToBounds = true
//            Email.backgroundColor = .white
//            Email.text = "krishna.pothapragada.607@k12.friscoisd.org"
//            Email.textColor = .systemBlue
//            Email.textAlignment = .center
            
            
        }
    }
    func setUpButton(){
        let buttonWidth = screenWidth * 0.5
        let buttonHeight = screenHeight * 0.05
        let buttonX = (screenWidth-buttonWidth) / 2
        let buttonY = screenHeight * 0.6
        btn.frame = CGRect(x:buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        btn.setTitle("Tap to show contact info", for: .normal)
        btn.addTarget(self, action: #selector(showContactInfo(_:)), for: .touchUpInside)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        view.addSubview(btn)
    }
    
    func setUpLabeles(){
        let LabelNameHight = screenHeight * 0.22
        let LabelNameWidth = screenWidth * 0.76767676767
        let LabelNameX = (screenWidth - LabelNameWidth) / 2
        let LabelNameY = screenHeight * 0.365
        Name.frame = CGRect(x:LabelNameX, y:LabelNameY, width: LabelNameWidth, height:LabelNameHight)
        Desc.frame = CGRect(x:LabelNameX, y:LabelNameY+50, width: LabelNameWidth, height: LabelNameHight)
        Desc.textAlignment = .center
        Name.textAlignment = .center
        Desc.textColor = .white
        Desc.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        Name.text = "Krishna Pothapragada"
        Name.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
        Name.textColor = .white
        Desc.text = "ML engineer"
        view.addSubview(Name)
        view.addSubview(Desc)
    }
    func setUpContactLabel(){
        let LabelWidth = screenWidth * 0.5
        let LabelHeight = screenHeight * 0.04
        let LabelX = (screenWidth-LabelWidth) / 2
        let LabelY = screenHeight * 0.7
        let offset: CGFloat = 150
        phoneNumber = UILabel( frame: CGRect(x: LabelX, y:LabelY, width: LabelWidth, height: LabelHeight))
        phoneNumber.layer.cornerRadius = 10
        phoneNumber.layer.masksToBounds = true
        phoneNumber.backgroundColor = .white
        phoneNumber.text = "112-990-7882"
        phoneNumber.textColor = .systemBlue
        phoneNumber.textAlignment = .center
        Email = UILabel( frame: CGRect(x: LabelX-70, y:LabelY+50, width: LabelWidth+offset, height: LabelHeight))
        Email.layer.cornerRadius = 10
        Email.layer.masksToBounds = true
        Email.backgroundColor = .white
        Email.text = "krishna.pothapragada.607@k12.friscoisd.org"
        Email.textColor = .systemBlue
        Email.textAlignment = .center
        view.addSubview(phoneNumber)
        view.addSubview(Email)
        Email.isHidden.toggle()
        phoneNumber.isHidden.toggle()
    }
    func PFP(){
        let picWidth = screenWidth * 0.4981
        let picHeight = screenHeight * 0.243
        let picX = (screenWidth-picWidth) / 2
        let picY = screenHeight * 0.19
        pic.frame = CGRect(x: picX, y: picY, width: picWidth, height: picHeight)
        
        pic.image = UIImage(named: "SchoolPFP")
        
        
        pic.layer.cornerRadius = pic.frame.size.height * 0.4821100000000001
        pic.layer.masksToBounds = true
        pic.layer.borderWidth = 3
        pic.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(pic)

    }

}

