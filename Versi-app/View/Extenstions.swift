//
//  RoundedBorderButton.swift
//  Versi-app
//
//  Created by Amany Shady on 12/01/2023.
//

import Foundation
import UIKit
import SafariServices

    
    extension UIButton {
     
        func buttonRoundedBorder() {
            
            self.backgroundColor = UIColor.clear
            layer.cornerRadius = frame.height / 2
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 3
        }
    }


extension UITextField {
    
    func roundedBorderTextField() {
        
        backgroundColor = UIColor.white
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 3
        
        let placeholder = NSAttributedString(string: self.placeholder! , attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue])
        
        attributedPlaceholder = placeholder
    }
}
   

extension UIImageView {
 
    func imageRoundedBorder() {
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = false
        clipsToBounds = true
   
    }
}


extension UIViewController {
    
    func presentSFSafariVCFor(url : String){
        
       let readmyUrl = URL(string: url + readmeSegment)
        
        let safariVc = SFSafariViewController(url: readmyUrl!)
        
        present(safariVc, animated: true)
        
    }
}

