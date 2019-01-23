//
//  ViewController.swift
//  Calender
//
//  Created by musbah on 1/23/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var gregorianTF: UITextField!
    
    private var datePicker: UIDatePicker?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl.text! = getDateTime()
        gregorianTF.text! = getDateTime()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(ViewController.selectDate), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTaped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        gregorianTF.inputView = datePicker
        
    }

    @objc func viewTaped(gestureRecognizer:UITapGestureRecognizer)  {
        view.endEditing(true)
    }
    func getDateTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter.string(from: Date())
    }
    
    @IBAction func ConvertTime(_ sender: Any) {
        lbl.text! = toIslamic()
        
    }
    func toIslamic() -> String {
        if gregorianTF.text!.isEmpty {return "Enter valid date"}
        let text = gregorianTF.text!
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let GregorianDate = dateFormatter.date(from: text)
        let islamic = Calendar(identifier: Calendar.Identifier.islamicUmmAlQura)
        let components = (islamic as NSCalendar?)?.components(NSCalendar.Unit(rawValue: UInt.max), from: GregorianDate!)
        let fina_date = "\(components!.day!)/\(components!.month!)/\(components!.year!)"
        print("final Islamic Date :: \(fina_date)") // 18/9/1412
        return fina_date
        
    }

    @objc func selectDate(datePicker: UIDatePicker)  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        gregorianTF.text! = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}

