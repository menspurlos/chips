//
//  ChipsModel.swift
//  chips
//
//  Created by Дмитрий Гришкин on 28.06.2024.
//

import Foundation

struct Reliability: Hashable {
    let color: String?
    let iconUrl: String?
    let title: String?
    let description: String?
    let alternative: Alternative?
}

extension Reliability {
    struct Alternative: Hashable {
        let title: String?
        let description: String?
        let alternatives: [AlternativeList]?
    }
}

extension Reliability.Alternative {
    struct AlternativeList: Hashable {
        let title: String?
        let url: String?
    }
}
