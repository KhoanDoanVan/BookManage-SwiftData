//
//  PreviewContainer.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 21/11/24.
//

import SwiftData
import Foundation


struct Preview {
    let container: ModelContainer
    
    /// Pass any type models
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create preview container")
        }
    }
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
