//
//  FilterPanel.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import SwiftUI

struct FilterPanel: View {
    var currentMode: JournalViewModel.SortMode
    var currentFilter: JournalViewModel.FilterMode
    var onSelectBookmarkOnly: () -> Void
    var onSelectEntryDateAll: () -> Void
    var onDismissOutside: () -> Void

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { onDismissOutside() }

            VStack(spacing: 0) {
                Button(action: onSelectBookmarkOnly) {
                    panelRow(
                        text: "Sort by Bookmark",
                        isSelected: currentFilter == .bookmarkedOnly
                    )
                }

                Divider().background(Color.white.opacity(0.25))

                Button(action: onSelectEntryDateAll) {
                    panelRow(
                        text: "Sort by Entry Date",
                        isSelected: currentFilter == .all && currentMode == .entryDateDesc
                    )
                }
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.white.opacity(0.18))
            )
            .shadow(color: .black.opacity(0.6), radius: 12, x: 0, y: 8)
            .frame(width: 280)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(.trailing, 0)
    }

    private func panelRow(text: String, isSelected: Bool) -> some View {
        HStack {
            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
    }
}

#Preview {
    FilterPanel(
        currentMode: .entryDateDesc,
        currentFilter: .all,
        onSelectBookmarkOnly: {},
        onSelectEntryDateAll: {},
        onDismissOutside: {}
    )
    .background(.black)
}
