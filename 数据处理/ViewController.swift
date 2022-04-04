//
//  ViewController.swift
//  数据处理
//
//  Created by 李思聪 on 2019/9/12.
//  Copyright © 2019 李思聪. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
      
        start.numberOfLines = 2
        start.text! = "开始创建你的\n数据处理"
        start.adjustsFontSizeToFitWidth = true
    }

    var probabilityNumber = 0.95
    
    @IBOutlet weak var probability900Button: UIButton!
    @IBOutlet weak var probability950Button: UIButton!
    @IBOutlet weak var probability975Button: UIButton!
    @IBOutlet weak var probability990Button: UIButton!
    @IBOutlet weak var probability995Button: UIButton!
    
    
    
    @IBOutlet weak var start: UILabel!
   

    @IBAction func conForm(_ sender: UIButton) {
            self.performSegue(withIdentifier: "nextPage", sender: self)
    }
    
    @IBAction func probability900(_ sender: UIButton) {
        bianInitAll()
        bian(button: probability900Button)
        probabilityNumber = 0.900
    }
    
    @IBAction func probability950(_ sender: UIButton) {
        bianInitAll()
        bian(button: probability950Button)
        probabilityNumber = 0.950
    }
    
    @IBAction func probability975(_ sender: UIButton) {
        bianInitAll()
        bian(button: probability975Button)
        probabilityNumber = 0.975
    }

    @IBAction func probability990(_ sender: UIButton) {
        bianInitAll()
        bian(button: probability990Button)
        probabilityNumber = 0.990
    }
    
    @IBAction func probability995(_ sender: UIButton) {
        bianInitAll()
        bian(button: probability995Button)
        probabilityNumber = 0.995
    }
    
    func bianInit(button: UIButton!){
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    func bianInitAll(){
        bianInit(button: probability900Button)
        bianInit(button: probability950Button)
        bianInit(button: probability975Button)
        bianInit(button: probability990Button)
        bianInit(button: probability995Button)
    }
    
    func bian(button: UIButton!){
        button.backgroundColor = #colorLiteral(red: 0.9986158013, green: 0.5330039859, blue: 0.5323150754, alpha: 1)
        button.setTitleColor(.white, for: .normal)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    {
        if segue.identifier == "nextPage"
        {
            let secondPage = segue.destination as! SecendPage
            secondPage.probabilityNumber = self.probabilityNumber
        }
    }
    

    }

    



public func initTextBox( textName: UITextField!) {
    textName.isSecureTextEntry = false
    textName.keyboardType = .default
    textName.clearButtonMode = .whileEditing
    textName.returnKeyType = UIReturnKeyType.done
    textName.becomeFirstResponder()
    textName.adjustsFontSizeToFitWidth = true
    
}
