//
//  String+Searchable.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

extension String {
    func searchable() -> String {
        return self.lowercased().trimmingCharacters(in: .whitespaces)
    }
}
