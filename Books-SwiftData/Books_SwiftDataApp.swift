//
//  Books_SwiftDataApp.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 20/11/24.
//

import SwiftUI
import SwiftData

@main
struct Books_SwiftDataApp: App {
    
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(container)
//        .modelContainer(for: Book.self)
    }
    
    init() {
        
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
