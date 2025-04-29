//
//  CountryPickerViewProxy.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//


import UIKit
import SwiftUI
import CountryPicker

struct CountryPickerViewProxy: UIViewControllerRepresentable {
    
    let onSelect: (( _ choosenCountry: Country) -> Void)?
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: CountryPickerController.create {
            onSelect?($0)}
        )
    }
}
