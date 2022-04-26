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
    
    func notify(_ resident: Resident) {
        guard let resident = residents.first(where: { $0.id == resident.id }) else { return }
        networkController.post(endpoint: .notifications, sentModel: NotificationNetworkModel(from: resident)) { [weak self] (result: Result<EmptyNetworkModel, Error>) in
            guard let _ = try? result.get() else {
                // TODO: handle error
                return
            }
            DispatchQueue.main.async {
                // TODO: show alert of sent notification
                print("Returned from call")
            }
        }
    }
    
    func loadResidents() {
        networkController.get(endpoint: .packages) { [weak self] (result: Result<PackagesNetworkModel, Error>) in
            guard let packagesResult = try? result.get() else {
                // TODO: handle error
                return
            }
            AppLogger.debug("Received package results: \n\(packagesResult.description)")
            let residents = packagesResult.residents
            AppLogger.debug("Built resident list: \(residents)")
            DispatchQueue.main.async {
                self?.residents = residents
            }
        }
    }
}
