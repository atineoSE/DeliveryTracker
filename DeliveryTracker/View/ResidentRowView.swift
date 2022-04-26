//
//  ResidentRowView.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

struct ResidentRowView: View {
    let resident: Resident
    let notificationAction: () -> Void
    
    private var buttonText: String {
        let count = resident.packages.count
        return "Notify of \(count) package" + ( count > 1 ? "s" : "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                resident.image
                    .resizable()
                    .frame(width: .imageSide, height: .imageSide)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(resident.name)
                        .bold()
                    Text(resident.email)
                }
            }
            Text("Packages:")
                .bold()
            PackagesView(packages: resident.packages)
            
            NotificationButton(action: notificationAction) {
                Text(buttonText)
            }
        }
    }
}
