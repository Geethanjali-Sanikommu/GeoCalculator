//
//  PickerViewController.swift
//  GeoCalculator
//
//  Created by geethanjali on 5/19/18.
//  Copyright © 2018 edu.gvsu.cis. All rights reserved.
//
//Geethanjali Sanikommu, Jidnyasa Mantri
import UIKit

protocol PickerViewControllerDelegate {
func settingsChanged(distanceUnit: String, bearingUnit: String)
}

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var distanceUnit: UITextField!
    @IBOutlet weak var bearingUnit: UITextField!
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var Cancel: UIBarButtonItem!
    @IBOutlet weak var Save: UIBarButtonItem!
    
    
    var delegate: PickerViewControllerDelegate?
    var units:[String] = [String]()
    var picker = 0
    
    var Unit1: String?
    var Unit2 : String?
    
/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let FC = segue.destination as! ViewController
        FC.selectDistanceUnits = distanceUnit.text!
        FC.selectBearingUnits = bearingUnit.text!
    }*/
   
    @IBAction func CancelPressed(_ sender: UIButton) {
     dismiss(animated: true, completion: nil)
    }
   
    @IBAction func SavePressed(_ sender: Any) {
       
       // performSegue(withIdentifier: "segue", sender: self)
        
       // dismiss(animated: true, completion: nil)
        
     /*   let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.selectDistanceUnits = distanceUnit.text!
        vc.selectBearingUnits = bearingUnit.text!
        navigationController? .pushViewController(vc, animated: true)*/
       // dismiss(animated: true, completion: nil)
        self.delegate?.settingsChanged(distanceUnit: Unit1!, bearingUnit: Unit2!)
        self.dismiss(animated: true, completion: nil)

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerView.dataSource = self
        PickerView.delegate = self
        
       //  distanceUnit.text = Unit1!
       //  bearingUnit.text = Unit2!
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideView))
        view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        distanceUnit.isUserInteractionEnabled = true
        distanceUnit.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action:#selector(self.tapFunction1))
        bearingUnit.isUserInteractionEnabled = true
        bearingUnit.addGestureRecognizer(tap2)
        
        
        // Do any additional setup after loading the view.
    }
   @objc func tapFunction(sender:UITapGestureRecognizer){
        self.units = ["kilometers","miles"]
        self.PickerView.reloadAllComponents()
        PickerView.isHidden = false
    }
    
    @objc func tapFunction1(sender:UITapGestureRecognizer){
        self.units = ["degrees","mils"]
        self.PickerView.reloadAllComponents()
        PickerView.isHidden = false
    }
    
    @objc func hideView(sender:UITapGestureRecognizer){
        self.PickerView.isHidden = true
    }
 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker = row
        
        if(self.units[0] == "kilometers" && picker == 0){
            self.distanceUnit.text = "kilometers"
            self.Unit1 = "kilometers"
        }
        else if(self.units[1] == "miles" && picker != 0){
            self.distanceUnit.text = "miles"
            self.Unit1 = "miles"
        }
        else if(self.units[0] == "degrees" && picker == 0){
            self.bearingUnit.text = "degrees"
            self.Unit2 = "degrees"
        }
        else if(self.units[1] == "mils" && picker != 0){
            self.bearingUnit.text = "mils"
            self.Unit2 = "mils"
        }
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
