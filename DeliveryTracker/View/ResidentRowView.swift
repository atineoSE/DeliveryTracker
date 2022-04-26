//
//  ResidentRowView.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

struct ResidentRowView: View {
    let resident: Resident
    
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
        }
    }
}
