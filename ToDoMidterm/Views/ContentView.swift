//
//  ContentView.swift
//  ToDoMidterm
//
//  Created by Quinn Brittain on 3/20/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showLaunchView: Bool = true

    var body: some View {
        ZStack {
            ListView()
            if showLaunchView {
                LaunchView(showLaunchView: $showLaunchView)
                    .transition(.move(edge: .leading))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
