//
//  SecendPage.swift
//  数据处理
//
//  Created by 李思聪 on 2019/9/14.
//  Copyright © 2019 李思聪. All rights reserved.
//  周期性和累进性名字写反了
//  第二页的名字还给拼错了，淦
import UIKit

class SecendPage: UIViewController, UITextFieldDelegate {

    
    let g900 = [1.148, 1.425, 1.602, 1.729, 1.828, 1.909, 1.977, 2.036, 2.088, 2.134, 2.175, 2.213, 2.247, 2.279, 2.309, 2.335, 2.361, 2.385]
    let g950 = [1.153, 1.463, 1.672, 1.822, 1.938, 2.032, 2.110, 2.176, 2.234, 2.285, 2.331, 2.371, 2.409, 2.443, 2.475, 2.501, 2.532, 2.557]
    let g975 = [1.155, 1.481, 1.715, 1.887, 2.020, 2.126, 2.215, 2.290, 2.355, 2.412, 2.462, 2.507, 2.549, 2.585, 2.620, 2.651, 2.681, 2.709]
    let g990 = [1.155, 1.481, 1.715, 1.887, 2.020, 2.126, 2.215, 2.290, 2.355, 2.412, 2.462, 2.507, 2.549, 2.585, 2.620, 2.650, 2.681, 2.709]
    let g995 = [1.155, 1.496, 1.764, 1.973, 2.139, 2.274, 2.387, 2.482, 2.564, 2.636, 2.699, 2.755, 2.806, 2.852, 2.894, 2.932, 2.968, 3.001]
    var probabilityNumber = 0.95
    var average = 0.0
    var standard = 0.0
    var position = 0
    var dataArray = [Double]()
    var arrayNumber = 0
    var sum = 0.0
    var judge = false
    var standardToCompare = 0.0
    var max = 0.0
    var numberOfRemove = 0
    var confidenceNumber = 0.0
    var confidenceIntervalUp = 0.0
    var confidenceIntervalDown = 0.0
    var periodicity = true
    var progressvicity = true
    var subtractionArray = [Double]()
    var maxSubtraction = 0.0
    var periodicityNumber = 0.0
    var progressivityNumber = 0.0
    var periodicityNumberUp = 0.0
    var periodicityNumberDown = 0.0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.placeholder = "至少再输入3个数据"
        data.delegate = self
        data.keyboardType = .numbersAndPunctuation
        // Do any additional setup after loading the view.
    
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == data
        {
            guard Double(data.text!) != nil else{
                data.text! = ""
                data.placeholder = "请输入数字"
                return false
            }
            switch arrayNumber {
            case 0...1 :
                dataArray.append(Double(data.text!)!)
                arrayNumber += 1
                data.placeholder = "至少再输入\(3 - arrayNumber)个数据"
            case 2...18 :
                dataArray.append(Double(data.text!)!)
                arrayNumber += 1
                data.placeholder = ""
            default:
                data.placeholder = "数据已满"
            }
            data.text! = ""
            showWhatWriteIn.text! = dataArray.description
        }
        return true
    }
    
    
    @IBOutlet weak var data: UITextField!
    
    
    @IBAction func deleteData(_ sender: UIButton) {
        if dataArray.count != 0 {
            dataArray.remove(at: dataArray.index(before: dataArray.endIndex))
            arrayNumber -= 1
            if arrayNumber <= 2 {
                data.placeholder = "至少再输入\(3 - arrayNumber)个数据"
            }
            
        }
        showWhatWriteIn.text! = dataArray.description
    }
    
    
    @IBAction func loggingComplete(_ sender: UIButton) {
        if arrayNumber <= 2 {
            showWhatWriteIn.text! = "至少再输入\(3 - arrayNumber)个数据"
        }else{
        while judge == false {
            findAverage()
            findStandard()
            findStandardToCompare()
            findMax()
            if abs(max - average) > standardToCompare {
                dataArray.remove(at: position)
                numberOfRemove += 1
                arrayNumber -= 1
            }else{
                judge = true
            }
            
        }
            findConfidenceInterval()
            periodicityJudge()
            progressvicityJudge()
            self.performSegue(withIdentifier: "lastPage", sender: self)
            }
            
        }
        
   
    
    @IBOutlet weak var showWhatWriteIn: UILabel!
    
    func findAverage()  {
        sum = 0
        for index in dataArray {
            sum += index
        }
        average = sum / Double(arrayNumber)
    }
    
    func findStandard()  {
        standard = 0
        for index in dataArray {
            standard += pow(index, 2)
        }
        standard = pow((standard - Double(arrayNumber) * pow(average, 2)) / Double((arrayNumber - 1)), 0.5)
    }
    
    func findMax() {
        max = dataArray[0]
        for index in 0..<dataArray.count  {
            if abs(max - average) < abs(dataArray[index] - average){
                max = dataArray[index]
                position = index
            }
        }
    }
    
    func findStandardToCompare(){
        switch probabilityNumber {
        case 0.90:
            standardToCompare = standard * g900[arrayNumber - 3]
        case 0.95:
            standardToCompare = standard * g950[arrayNumber - 3]
        case 0.975:
            standardToCompare = standard * g975[arrayNumber - 3]
        case 0.99:
            standardToCompare = standard * g990[arrayNumber - 3]
        case 0.995:
            standardToCompare = standard * g995[arrayNumber - 3]
        default:
            standardToCompare = 0
        }
    }
    
    func findConfidenceInterval () {
        confidenceNumber = standard / pow(Double(arrayNumber), 0.5)
        confidenceIntervalUp = average + confidenceNumber
        confidenceIntervalDown = average - confidenceNumber
        
        
    }
    
    func periodicityJudge() {
        subtraction()
        if arrayNumber % 2 == 0 {
            evenjudge()
            if periodicityNumber > maxSubtraction {
               periodicity = true
            }else{
               periodicity = false
            }
        }else{
            oddjudge()
            if periodicityNumber > maxSubtraction {
                periodicity = true
            }else{
                periodicity = false
            }
        }
    }
    
    func progressvicityJudge() {
        subtraction()
        for index in 0...subtractionArray.count - 2{
            progressivityNumber += subtractionArray[index] * subtractionArray[index+1]
        }
        progressivityNumber = abs(progressivityNumber)
        if progressivityNumber > pow(Double(subtractionArray.count - 1), 0.5)*pow(probabilityNumber, 2){
            progressvicity = true
        }else{
            progressvicity = false
        }
        
    }
    
    func subtraction (){
        for index in dataArray {
            subtractionArray.append(index - average)
        }
    }
    
    func findMaxSubtraction (){
        subtraction()
        maxSubtraction = abs(subtractionArray[0])
        for index in dataArray {
            if abs(index) > maxSubtraction{
                maxSubtraction = abs(index)
            }
            
        }
    }
    
    func evenjudge() {
       
        for index in 0...(subtractionArray.count/2 - 1) {
           periodicityNumberUp += subtractionArray[index]
        }
        for index in (subtractionArray.count/2 + 1)...(subtractionArray.count - 1){
            periodicityNumberDown += subtractionArray[index]
        }
        periodicityNumber = abs(periodicityNumberUp - periodicityNumberDown)
        findMaxSubtraction()
        
    }
    
    func oddjudge() {
        for index in 0...(subtractionArray.count - 1)/2 {
            periodicityNumberUp += subtractionArray[index]
        }
        for index in (subtractionArray.count + 1)/2...(subtractionArray.count - 1){
            periodicityNumberDown += subtractionArray[index]
        }
        periodicityNumber = abs(periodicityNumberUp - periodicityNumberDown)
        findMaxSubtraction()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.data.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "lastPage"
        {
            let lastPage = segue.destination as! LastPage
            lastPage.periodicity = self.periodicity
            lastPage.progressvicity = self.progressvicity
            lastPage.confidenceIntervalUp = self.confidenceIntervalUp
            lastPage.confidenceIntervalDown = self.confidenceIntervalDown
            lastPage.numberOfRemove = self.numberOfRemove
            lastPage.average = self.average
            lastPage.arrayNumber = self.arrayNumber
            lastPage.dataArray = self.dataArray
        }
    }
}
