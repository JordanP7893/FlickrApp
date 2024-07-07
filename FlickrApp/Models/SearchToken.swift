//
//  SearchToken.swift
//  FlickrApp
//
//  Created by Jordan Porter on 07/07/2024.
//

import Foundation

struct Token: Identifiable, Hashable {
    let text: String

    var id: String {
        text
    }
}
