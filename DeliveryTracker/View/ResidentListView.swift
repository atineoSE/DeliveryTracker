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
        List(viewModel.residents) { resident in
            ResidentRowView(resident: resident) {
                viewModel.notify(resident)
            }
        }
        .navigationTitle("Residents")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.loadResidents()
        }
        .refreshable {
            viewModel.loadResidents()
        }
    }
}
