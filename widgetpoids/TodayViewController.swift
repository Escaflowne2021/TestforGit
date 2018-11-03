//
//  TodayViewController.swift
//  widgetpoids
//
//  Created by Cormier on 21/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, DataLive {
    
    @IBOutlet weak var L_Resultat: UILabel!
    @IBOutlet weak var light: Light!
    
    //lazy var comp = Component_Compteur()
    
    func pourcentagePoidsLive(pourcentage: Int) {
        print("OK WIDGET \(pourcentage)")
        L_Resultat.text = "La bouteille est à \(pourcentage) %"
        self.light.PingLight()
    }
    
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Component_Compteur.DelaguateDataLive = self
        print("widget")
        Component_Compteur.delagates.add(delegate: self)
        //comp.DelaguateDataLive = self
        //prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
        
       
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
