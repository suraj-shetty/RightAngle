//
//  DatePickerField.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import Foundation
import SwiftUI

enum SGTextFieldType {
    case textField
    case date
    case time
}

struct SGDatePickerField: UIViewRepresentable {
    @Binding var date: Date?
    let fieldType: SGTextFieldType
    init(date: Binding<Date?>, fieldType: SGTextFieldType) {
        self._date = date
        self.fieldType = fieldType
    }
    
    func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        if let date = date {
            uiView.text = dateString(from: date)
        }
    }
    
    func makeUIView(context: Context) -> DatePickerTextField {
        let pickerField = DatePickerTextField(date: $date, fieldType: fieldType)
        pickerField.font =  UIFont.systemFont(ofSize: 19, weight: .medium) //SGFont(.installed(.GTWalsheimProMedium), size: .custom(19.0)).instance
        
        if let date = date {
            pickerField.text = dateString(from: date)
        }
        
        return pickerField
    }
    
    private func dateString(from date: Date?) -> String? {
        guard let date = date else {
            return nil
        }

        let dateFormatter = DateFormatter()
        let format = fieldType == .date ? "MMM d, yyyy" : "hh:mm a"
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}


struct SGBirthDatePickerField: UIViewRepresentable {
    @Binding var date: Date?
    let maxDate: Date
    let textColor: UIColor
    init(date: Binding<Date?>, maxDate:Date, textColor: UIColor = .black) {
        self._date = date
        self.maxDate = maxDate
        self.textColor = textColor
    }
    
    func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        if let date = date {
            uiView.text = dateString(from: date)
        }
    }
    
    func makeUIView(context: Context) -> DatePickerTextField {
        let pickerField = DatePickerTextField(date: $date, maxDate: maxDate, fieldType: .date)
        pickerField.textColor = textColor
        pickerField.tintColor = textColor
        pickerField.font =  UIFont.systemFont(ofSize: 16, weight: .regular) //SGFont(.installed(.GTWalsheimProMedium), size: .custom(19.0)).instance
        
        if let date = date {
            pickerField.text = dateString(from: date)
        }
        
        return pickerField
    }
    
    private func dateString(from date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        let format = "MMM d, yyyy"
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}


class DatePickerTextField: UITextField {
    @Binding var date: Date?
    private let datePicker = UIDatePicker()

    init(date: Binding<Date?>, maxDate: Date? = nil, fieldType: SGTextFieldType) {
        self._date = date
        super.init(frame: .zero)
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = fieldType == .date ? .date : .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .black
        
        if let maxDate = maxDate {
            datePicker.maximumDate = maxDate
        }
        else if fieldType == .date {
            datePicker.minimumDate = Date()
        }
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissTextField))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @objc private func dismissTextField() {
        resignFirstResponder()
    }
}
