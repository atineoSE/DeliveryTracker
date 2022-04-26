//
//  ResidentListView.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

struct ResidentListView: View {
    @StateObject var viewModel: ResidentListViewModel
    
    var body: some View {
        List {
           Text("Dummy row")
        }
        .navigationTitle("Residents")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.loadResidents()
        }
    }
}
