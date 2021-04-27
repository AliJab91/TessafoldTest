//
//  Extensions.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//
import SVProgressHUD
import Foundation

extension UIViewController {
    func showLoader() {
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
}
