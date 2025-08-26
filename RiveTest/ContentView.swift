//
//  ContentView.swift
//  RiveTest
//
//  Created by Leszek.Mzyk on 26/08/2025.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    var body: some View {
        RiveAnimationView()
    }
}

private struct RiveAnimationView: View {
    let viewModel = RiveViewModel(
        fileName: "vm_initial",
        fit: .layout,
        autoPlay: true
    )
    
    init () {
        viewModel.riveModel?.enableAutoBind { instance in
            // noop
        }

    }
    
    var body: some View {
        viewModel.view()
    }
}

#Preview {
    ContentView()
}
