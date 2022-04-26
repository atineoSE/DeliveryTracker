//
//  PackagesView.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

struct PackagesView: View {
    let packages: [Package]
    
    private let columns: [GridItem] = Array(repeating: GridItem(), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: .small) {
            ForEach(packages) { package in
                VStack {
                    Text(package.type)
                    Text(package.carrier)
                        .font(.footnote)
                }
                .card(width: .imageSide, height: .imageSide)
            }
        }
    }
}
