//
//  String+Extensions.swift
//  FlickrApp
//
//  Created by Jordan Porter on 04/07/2024.
//

import Foundation

extension String {
    func convertBlankToNil() -> String? {
        if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return nil
        } else {
            return self
        }
    }
}
