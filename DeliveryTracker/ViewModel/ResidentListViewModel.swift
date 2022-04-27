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
    @Published var alert: PresentedAlert?
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    func notify(_ resident: Resident, successfulCompletion: (() -> Void)? = nil, failedCompletion: (() -> Void)? = nil) {
        guard let resident = residents.first(where: { $0.id == resident.id }) else { return }
        networkController.post(endpoint: .notifications, sentModel: NotificationNetworkModel(from: resident)) { [weak self] (result: Result<EmptyNetworkModel, Error>) in
            do {
                let _ = try result.get()
                DispatchQueue.main.async {
                    self?.alert = .notificationsSent(name: resident.name, packageCount: resident.packages.count)
                    successfulCompletion?()
                }
            } catch {
                DispatchQueue.main.async {
                    self?.alert = .connectionError(message: error.localizedDescription)
                    failedCompletion?()
                }
            }
        }
    }
    
    func loadResidents(successfulCompletion: (() -> Void)? = nil, failedCompletion: (() -> Void)? = nil) {
        networkController.get(endpoint: .packages) { [weak self] (result: Result<PackagesNetworkModel, Error>) in
            do {
                let packagesResult = try result.get()
                AppLogger.debug("Received package results: \n\(packagesResult.description)")
                let residents = packagesResult.residents
                AppLogger.debug("Built resident list: \(residents)")
                DispatchQueue.main.async {
                    self?.residents = residents
                    successfulCompletion?()
                }
            } catch {
                DispatchQueue.main.async {
                    self?.residents = []
                    self?.alert = .connectionError(message: error.localizedDescription)
                    failedCompletion?()
                }
            }
        }
    }
}
