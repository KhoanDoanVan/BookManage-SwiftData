//
//  Book.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 20/11/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Book {
    
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    @Attribute(originalName: "summary") /// The attribute from swiftData to app knows the original name of the attributes you've just chance name of the attribute
    var synopsis: String /// new name (old name is summary)
    var rating: Int?
    var status: Status.RawValue
    var recommendedBy: String = "" /// If you want to update new properties but also don't want the app crash, you must be set the default value to the new properties
    @Relationship(deleteRule: .cascade) /// If the book has been deleted, all quotes has reference the book was deleted still existed, so using this for make sure delete all reference book relate to the book
    var quotes: [Quote]?
    @Relationship(inverse: \Genre.books) /// Many to many relationships
    var genres: [Genre]?
    @Attribute(.externalStorage) /// This is attribute to SwiftData know and storage large data outside the main sqlite database which is new folder in outside.
    var bookCover: Data?
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        synopsis: String = "",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    
    var icon: Image {
        switch Status(rawValue: status)! {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource { /// Changes String -> LocalizedStringResource
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
