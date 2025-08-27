//
//  CustomRiveViewModel.swift
//  RiveTest
//
//  Created by Leszek.Mzyk on 27/08/2025.
//

import SwiftUI
import RiveRuntime
import os

private let logger = Logger(subsystem: "com.yourapp.rive", category: "CustomRiveViewModel")

class CustomRiveViewModel: RiveViewModel {
    init(x:Float, y:Float) {
        logger.debug("TEST: create custom rive: \(x), \(y)")
       super.init(fileName: "vm_initial", fit: .layout)
       riveModel?.enableAutoBind { instance in
           instance.numberProperty(fromPath: "pos x")!.value = x
           instance.numberProperty(fromPath: "pos y")!.value = y
           
           logger.debug("TEST: new position in vm: \(instance.numberProperty(fromPath: "pos x")!.value), \(instance.numberProperty(fromPath: "pos y")!.value)")
           
           instance.numberProperty(fromPath: "pos x")!.addListener { newX in
               logger.debug("TEST: position x in vm: \(newX)")
           }
           
           instance.numberProperty(fromPath: "pos y")!.addListener { newY in
               logger.debug("TEST: position y in vm: \(newY)")
           }
       }
        
   }
}
