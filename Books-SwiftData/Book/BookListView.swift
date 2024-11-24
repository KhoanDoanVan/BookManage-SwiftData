//
//  ContentView.swift
//  Books-SwiftData
//
//  Created by Đoàn Văn Khoan on 20/11/24.
//

import SwiftUI
import SwiftData

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable { /// Changes String -> LocalizedStringResource
    case status, title, author
    
    var id: Self {
        self
    }
}

struct BookListView: View {
    
    @State private var isReset: Bool = false
    @State private var createNewBook = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""

    var body: some View {
        NavigationStack {
            
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)")
                        .tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            
            Menu {
                Button("EN") {
                    LanguageManager.setLanguage("en")
                    isReset.toggle()
                }
                
                Button("VIE") {
                    LanguageManager.setLanguage("vi")
                    isReset.toggle()
                }
            } label: {
                HStack {
                    Image(systemName: "a.square.fill")
                    Text("Languages")
                }
            }

            
            BookList(
                sortOrder: sortOrder,
                filterString: filter
            )
                .searchable(text: $filter, prompt: Text("Filter on title or author"))
                .navigationTitle("My Books")
                .toolbar {
                    Button {
                        createNewBook = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                .sheet(isPresented: $createNewBook) {
                    NewBookView()
                        .presentationDetents([.medium])
                }
                .alert("The app has been shutdown", isPresented: $isReset) {
                    Button("OK") {
                        closeApp()
                    }
                }
        }
    }
    
    
    func closeApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.sampleGenres
    preview.addExamples(books)
    preview.addExamples(genres)
    return BookListView()
        .modelContainer(preview.container)
}
