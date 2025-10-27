//
//  JournalViewModel.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import Foundation
import SwiftUI
internal import Combine

@MainActor
final class JournalViewModel: ObservableObject {
    @Published var items: [MainCardItem] = []
    @Published var searchText: String = ""
    @Published var isShowingFilterMenu: Bool = false
    @Published var isPresentingNewEntry: Bool = false
    @Published var newTitle: String = ""
    @Published var newContent: String = ""
    @Published var sortMode: SortMode = .entryDateDesc
    @Published var filterMode: FilterMode = .all

    enum SortMode {
        case bookmarkFirst
        case entryDateDesc
    }

    enum FilterMode {
        case all
        case bookmarkedOnly
    }

    var filteredAndSortedItems: [MainCardItem] {
        let filtered: [MainCardItem]
        switch filterMode {
        case .all:
            filtered = items
        case .bookmarkedOnly:
            filtered = items.filter { $0.isBookmarked }
        }

        switch sortMode {
        case .bookmarkFirst:
            return filtered.sorted {
                if $0.isBookmarked != $1.isBookmarked {
                    return $0.isBookmarked && !$1.isBookmarked
                } else {
                    return $0.date > $1.date
                }
            }
        case .entryDateDesc:
            return filtered.sorted { $0.date > $1.date }
        }
    }

    func toggleBookmark(for id: UUID) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isBookmarked.toggle()
    }

    func deleteItem(id: UUID) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
            items.removeAll { $0.id == id }
        }
    }

    func saveNewEntry() {
        let trimmedTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = newContent.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty, !trimmedContent.isEmpty else { return }

        let newItem = MainCardItem(title: trimmedTitle, content: trimmedContent)
        items.insert(newItem, at: 0)
        resetForm()
    }

    func resetForm() {
        newTitle = ""
        newContent = ""
        isPresentingNewEntry = false
    }
}
