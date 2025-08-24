//
//  TranslaterReques.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 23.08.2025.
//

import Foundation

struct TranslaterRequest: Encodable {
    let sourceLanguageCode: String = "en"
    let targetLanguageCode: String = "ru"
    let format: String = "PLAIN_TEXT"
    let texts: [String]
    let folderId: String = "b1gtben7nisn71ek59d9"
    let speller: Bool = true
}
