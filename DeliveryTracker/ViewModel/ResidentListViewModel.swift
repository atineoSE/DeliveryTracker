//
//  ResidentListViewModel.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

class ResidentListViewModel: ObservableObject {
    private let networkController: NetworkController
    @Published private(set) var residents: [Resident] = []
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
}
