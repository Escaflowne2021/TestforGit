//
//  Bluetooth.swift
//  TestforGit
//
//  Created by Cormier on 19/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//


import CoreBluetooth


class Bluetooth: NSObject,CBCentralManagerDelegate, CBPeripheralDelegate  {
    
    
    var centralManager:CBCentralManager!
    var sensorTag:CBPeripheral?
    // define our scanning interval times
    let timerPauseInterval:TimeInterval = 10.0
    let timerScanInterval:TimeInterval = 2.0
    
    weak var delagateB: DelegateBlueTooth?
    var characteristic: CBCharacteristic?
    
    var keepScanning = false
    //var isScanning = false
    
    
    func Go(){
        print("Debut")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func connectTo(périphérique: CBPeripheral){
        centralManager.connect(périphérique, options: nil)
    }
    
    @objc func pauseScan() {
        // Scanning uses up battery on phone, so pause the scan process for the designated interval.
        print("*** PAUSING SCAN...")
        _ = Timer(timeInterval: timerPauseInterval, target: self, selector: #selector(resumeScan), userInfo: nil, repeats: false)
        centralManager.stopScan()
        
    }
    @objc func resumeScan() {
        if keepScanning {
            // Start scanning again...
            print("*** RESUMING SCAN!")
            _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            
        }
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("ok")
        
        var message = ""
        
        switch central.state {
        case .poweredOff:
            message = "Bluetooth on this device is currently powered off."
        case .unsupported:
            message = "This device does not support Bluetooth Low Energy."
        case .unauthorized:
            message = "This app is not authorized to use Bluetooth Low Energy."
        case .resetting:
            message = "The BLE Manager is resetting; a state update is pending."
        case .unknown:
            message = "The state of the BLE Manager is unknown."
        case .poweredOn:
            
            message = "Bluetooth LE is turned on and ready for communication."
            
            print(message)
            keepScanning = true
            // _ = Timer(timeInterval: timerScanInterval, target: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
            
            // Initiate Scan for Peripherals
            //Option 1: Scan for all devices
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            
            // Option 2: Scan for devices that have the service you're interested in...
            //let sensorTagAdvertisingUUID = CBUUID(string: Device.SensorTagAdvertisingUUID)
            //print("Scanning for SensorTag adverstising with UUID: \(sensorTagAdvertisingUUID)")
            //centralManager.scanForPeripheralsWithServices([sensorTagAdvertisingUUID], options: nil)
        }
        
        
    }
    func centralManager(_: CBCentralManager, didDiscover: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber){
        print("centralManager didDiscoverPeripheral - CBAdvertisementDataLocalNameKey is \"\(CBAdvertisementDataLocalNameKey)\"")
        
        // Retrieve the peripheral name from the advertisement data using the "kCBAdvDataLocalName" key
        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            print("NEXT PERIPHERAL NAME: \(peripheralName)")
            print("NEXT PERIPHERAL UUID: \(didDiscover.identifier.uuidString)")
            self.delagateB?.ListPeriphérique(Peripherique: didDiscover)
            if peripheralName == "SH-HC-08" {
                centralManager.stopScan()
                
                print("SENSOR TAG FOUND! ADDING NOW!!!")
                // to save power, stop scanning for other devices
                keepScanning = true
                //disconnectButton.enabled = true
                
                // save a reference to the sensor tag
                sensorTag = didDiscover
                sensorTag!.delegate = self
                
                // Request a connection to the peripheral
                //centralManager.connectPeripheral(sensorTag!, options: nil)
                //centralManager.connect(sensorTag!, options: nil)
            }
        }
        
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        print("**** SUCCESSFULLY CONNECTED TO SENSOR TAG!!!")
        delagateB?.Connecté(ok: true)
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            print("ERROR DISCOVERING SERVICES: \(String(describing: error?.localizedDescription))")
            return
        }
        
        // Core Bluetooth creates an array of CBService objects —- one for each service that is discovered on the peripheral.
        if let services = peripheral.services {
            for service in services {
                print("Discovered service \(service)")
                // If we found either the temperature or the humidity service, discover the characteristics for those services.
                if (service.uuid.uuidString == "FFE0") {
                    print("OK service FFE0")
                    //sensorTag?.setNotifyValue(true, for: <#T##CBCharacteristic#>)
                    
                    peripheral.discoverCharacteristics(nil, for: service)
                    
                }
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            sensorTag?.setNotifyValue(true, for: characteristic)
            print(characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        switch characteristic.uuid.uuidString {
        case "FFE1":
            
            self.characteristic = characteristic
            let data: Data = characteristic.value!
            self.delagateB?.ReceiveData(data: data)
            
            
            
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
    
    func write(data: Data){
        sensorTag!.writeValue(data, for: self.characteristic!, type: .withoutResponse)
    }
    
    
    
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("deconnection détectée")
        delagateB?.Connecté(ok: false)
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
}
