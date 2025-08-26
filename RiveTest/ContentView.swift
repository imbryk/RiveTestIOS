//
//  ContentView.swift
//  RiveTest
//
//  Created by Leszek.Mzyk on 26/08/2025.
//

import SwiftUI
import RiveRuntime
import SwiftData
import os

private let logger = Logger(subsystem: "com.yourapp.rive", category: "CustomView")

struct ContentView: View {
    var body: some View {
        RiveAnimationView()
    }
}

private struct RiveAnimationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var positionData: [PositionData]
    
    @State private var x: Float = 200.0
    @State private var y: Float = 200.0
    
    private let dragKey = "dragging"
    
    let viewModel = RiveViewModel(
        fileName: "vm_initial",
        fit: .layout,
        autoPlay: true
    )
    
    var body: some View {
        viewModel.view()
            .onAppear {
                loadData()
                setupRive()
            }
    }
    
    private func loadData() {
        logger.debug("TEST: loadData called, positionData count: \(positionData.count)")
        
        // Load the most recent position data
        if let latestPosition = positionData.first {
            x = latestPosition.x
            y = latestPosition.y
            logger.debug("TEST: loaded from SwiftData: \(x), \(y)")
        } else {
            // Default values if no data exists
            x = 200.0
            y = 200.0
            logger.debug("TEST: no data found, using defaults: \(x), \(y)")
        }
    }
    
    private func setupRive() {
        guard let riveModel = viewModel.riveModel else { return }
        
        // Enable auto-binding for state machine
        riveModel.enableAutoBind { instance in
            logger.debug("TEST: position in vm: \(instance.numberProperty(fromPath: "pos x")!.value), \(instance.numberProperty(fromPath: "pos y")!.value)")
            logger.debug("TEST: position in prefs: \(x), \(y)")
            
            // Set initial position
            instance.numberProperty(fromPath: "pos x")!.value = x
            instance.numberProperty(fromPath: "pos y")!.value = y
            logger.debug("TEST: new position in vm: \(instance.numberProperty(fromPath: "pos x")!.value), \(instance.numberProperty(fromPath: "pos y")!.value)")
            
            // Observe dragging state
            instance.booleanProperty(fromPath: dragKey)!.addListener { isDragging in
                if !isDragging {
                    savePosition()
                }
            }
            
            // Observe position changes
            instance.numberProperty(fromPath: "pos x")!.addListener { newX in
                logger.debug("TEST: position x in vm: \(newX)")
                self.x = newX
            }
            
            instance.numberProperty(fromPath: "pos y")!.addListener { newY in
                logger.debug("TEST: position y in vm: \(newY)")
                self.y = newY
            }
        }
    }
    
    private func savePosition() {
        logger.info("TEST: savePosition called with x: \(x), y: \(y)")
        
        // Delete old position data
        for position in positionData {
            modelContext.delete(position)
        }
        
        // Create new position data
        let newPosition = PositionData(x: x, y: y)
        modelContext.insert(newPosition)
        
        // Save to persistent store
        do {
            try modelContext.save()
            logger.info("TEST: position saved successfully: \(x), \(y)")
        } catch {
            logger.error("TEST: failed to save position: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PositionData.self, inMemory: true)
}
