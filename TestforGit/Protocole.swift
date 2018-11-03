//
//  BluetoothProtocole.swift
//  TestforGit
//
//  Created by Cormier on 20/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol DelegateBlueTooth: class {
    
    func ListPeriphérique(Peripherique :CBPeripheral)
    func ReceiveData(data: Data)
    func Connecté(ok: Bool)
    
}

protocol DataLive: class {
    func pourcentagePoidsLive(pourcentage: Int)
}
