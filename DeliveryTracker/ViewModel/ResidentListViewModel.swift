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
    
    func loadResidents() {
        networkController.get(endpoint: .packages) { [weak self] (result: Result<PackagesNetworkModel, Error>) in
            guard let packagesResult = try? result.get() else {
                // TODO: handle error
                return
            }
            AppLogger.debug("Received package results: \n\(packagesResult.description)")
            DispatchQueue.main.async {
                self?.residents = packagesResult.residents
            }
        }
    }
}
