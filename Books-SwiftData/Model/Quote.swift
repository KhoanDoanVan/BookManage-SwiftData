//
//  Quote.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 22/11/24.
//

import Foundation
import SwiftData

@Model
class Quote {
    var createDate: Date = Date.now
    var text: String
    var page: String?
    
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
    
    var book: Book?
}
