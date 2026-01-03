//
//  SpotlightIndexer.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import CoreSpotlight
import UniformTypeIdentifiers

final class SpotlightIndexer {
    func index(id: String, title: String, description: String) {
        let attr = CSSearchableItemAttributeSet(contentType: .text)
        attr.title = title
        attr.contentDescription = description

        let item = CSSearchableItem(uniqueIdentifier: id,
                                    domainIdentifier: "tasks",
                                    attributeSet: attr)
        CSSearchableIndex.default().indexSearchableItems([item])
    }
}
