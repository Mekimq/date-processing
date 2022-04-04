//
//  LastPage.swift
//  数据处理
//
//  Created by 李思聪 on 2019/9/14.
//  Copyright © 2019 李思聪. All rights reserved.
//

import UIKit

class LastPage: UIViewController {

    
    
    var periodicity = true
    var progressvicity = true
    var confidenceIntervalUp = 0.0
    var confidenceIntervalDown = 0.0
    var numberOfRemove = 0
    var average = 0.0
    var arrayNumber = 0
    var dataArray = [Double]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        numberOfRemoveOutlet.text! = "\(numberOfRemove)"
        averageOutlet.text! = "\(average)"
        confidenceIntervalOutlet.text! = confidenceIntervalDown.text+"~~"+confidenceIntervalUp.text
        showDataLeft.text! = "\(dataArray)"
        showNumberOfData.text! = "还剩\(arrayNumber)个数据"
        
        if periodicity == true {
            periodicityOutlet.text! = "具有"
        }else{
            periodicityOutlet.text! = "不具有"
        }
        
        if progressvicity == true {
             progressvicityOutlet.text! = "具有"
        }else{
             progressvicityOutlet.text! = "不具有"
        }
        
        
        
        // Do any additional setup after loading the view.

    }
    
    @IBOutlet weak var periodicityOutlet: UILabel!
    
    @IBOutlet weak var progressvicityOutlet: UILabel!
    
    @IBOutlet weak var numberOfRemoveOutlet: UILabel!
    
    @IBOutlet weak var averageOutlet: UILabel!
    
    @IBOutlet weak var confidenceIntervalOutlet: UILabel!
    
    @IBOutlet weak var showDataLeft: UILabel!
    
    @IBOutlet weak var showNumberOfData: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension Double{
    var text: String{
        return String(format: "%.2f", self)
    }
}
