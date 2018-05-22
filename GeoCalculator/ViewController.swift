//
//  ViewController.swift
//  GeoCalculator
//
//  Created by geethanjali on 5/18/18.
//  Copyright © 2018 edu.gvsu.cis. All rights reserved.
//
// Geethanjali Sanikommu , Jidnyasa Mantri
import CoreLocation
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var Calculate: UIButton!
    @IBOutlet weak var Clear: UIButton!
    @IBOutlet weak var textField1: DecimalMinusTextField!
    @IBOutlet weak var textField2: DecimalMinusTextField!
    @IBOutlet weak var textField3: DecimalMinusTextField!
    @IBOutlet weak var textField4: DecimalMinusTextField!
    @IBOutlet weak var DUnit : UILabel!
    @IBOutlet weak var BUnit : UILabel!
    @IBOutlet weak var CalcResult: UILabel!
    @IBOutlet weak var BearingResult: UILabel!
    @IBOutlet weak var Settings: UIButton!
    @IBOutlet weak var distUnit: UILabel!
    @IBOutlet weak var beaUnit: UILabel!
    
    var selectDistanceUnits:String = "kilometers"
    var selectBearingUnits:String = "degrees"
    
    @IBAction func Calculate(_ sender: UIButton) {
      
        self.calculation()
        self.view.endEditing(true)
    }
    
    func settingsChanged(distanceUnits:String, bearingUnits:String){
        selectDistanceUnits = distanceUnits
        selectBearingUnits = bearingUnits
        self.calculation()
    }
    
    func calculation() {
        
        let t1 = Double(textField1.text!)
        let t2 = Double(textField2.text!)
        let t3 = Double(textField3.text!)
        let t4 = Double(textField4.text!)
        let coordinate1 = CLLocation(latitude: t1!, longitude: t2!)
        let coordinate2 = CLLocation(latitude: t3!, longitude: t4!)
        let distanceInMeters = coordinate1.distance(from:coordinate2)
        let distanceInKilometers = (distanceInMeters * 0.001)
        let roundDkilometer = Double(round(100*distanceInKilometers)/100)
        let distanceInMiles = (distanceInKilometers*0.621371)
        let roundDmiles = Double(round(100*distanceInMiles)/100)
          if(selectDistanceUnits == "kilometers"){
                self.CalcResult.text = "\(roundDkilometer) kilometers"
           }
          else{
             self.CalcResult.text = "\(roundDmiles) miles"
          }
        //bearing
       
        let bearingInDegrees = bearingResult(point1:coordinate1, point2:coordinate2)
        let bearingInMils = bearingInDegrees * 17.777777777778
        let roundDegrees = Double(round(100*(bearingInDegrees))/100)
        let roundMils = Double(round(100*(bearingInMils))/100)
        if(selectBearingUnits == "degrees"){
            self.BearingResult.text = "\(roundDegrees) degrees"
        }
        else {
            self.BearingResult.text = "\(roundMils) mils"
        }
     
    }
    
        func bearingResult(point1 : CLLocation, point2 : CLLocation) -> Double{
            
            let lat1 = DegreestoRadians(degrees: point1.coordinate.latitude)
            let long1 = DegreestoRadians(degrees: point1.coordinate.longitude)
            let lat2 = DegreestoRadians(degrees: point2.coordinate.latitude)
            let long2 = DegreestoRadians(degrees: point2.coordinate.longitude)
             let long = long2 - long1
            
            let y = sin(long)*cos(lat2)
            let x = cos(lat1)*sin(lat2)-sin(lat1)*cos(lat2)*cos(long)
            let radiansBearing = atan2(y,x)
            return Radianstodegrees(radians: radiansBearing)
         
        }
  
    func DegreestoRadians(degrees: Double)->Double{
        return degrees * .pi / 180.0
    }
    func Radianstodegrees(radians: Double) -> Double {
        return radians * 180.0 / .pi
    }
    
   
    
    @IBAction func ClearValues(_ sender: UIButton) {
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        CalcResult.text = ""
        BearingResult.text = ""
        textField1.isEnabled = true
        textField2.isEnabled = true
        textField3.isEnabled = true
        textField4.isEnabled = true
        self.view.endEditing(true)
    }
    
    
    @IBAction func Settingspressed(_ sender: Any) {
        performSegue(withIdentifier: "mySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let unit = segue.destination as? PickerViewController else { return}
        unit.Unit1 = self.selectDistanceUnits
        unit.Unit2 = self.selectBearingUnits
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // dismiss keyboard when tapping outside oftext fields
        
        distUnit.text = selectDistanceUnits
        beaUnit.text = selectBearingUnits
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }


}

