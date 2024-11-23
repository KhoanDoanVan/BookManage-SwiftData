//
//  Genre.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 23/11/24.
//

import SwiftData
import SwiftUI

@Model
class Genre {
    var name: String
    var color: String
    var books: [Book]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
