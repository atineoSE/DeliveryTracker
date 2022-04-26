//
//  AppImage.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

enum AppImage: String, CaseIterable {
    case hogwarts
    case gryffindor
    case slytherin
    case ravenclaw
    case hufflepuff
}

extension AppImage {
    var image: Image {
        guard let uiImage = UIImage(named: rawValue) else {
            return .default
        }
        return Image(uiImage: uiImage)
    }
}

extension Image {
    static let `default` = Image(systemName: "questionmark")
}
