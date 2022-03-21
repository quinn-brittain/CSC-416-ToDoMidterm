//
//  LaunchView.swift
//  ToDoMidterm
//
//  Created by Quinn Brittain on 3/20/22.
//

import SwiftUI

struct LaunchView: View {
    @Binding var showLaunchView: Bool
    private let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            Image("check-mark-icon")
                .resizable()
                .frame(width: 150, height: 150)
        }
        .onReceive(timer, perform: { _ in
            showLaunchView.toggle()
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
