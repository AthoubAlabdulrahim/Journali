//
//  CardView.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import SwiftUI

struct CardView: View {
    let item: MainCardItem
    let onToggleBookmark: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color("Purple"))

                Text(item.date, format: .dateTime.year().month().day())
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.8))

                Text(item.content)
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .lineLimit(3)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(Color.white.opacity(0.15), lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 6)

            // Bookmark button
            Button(action: onToggleBookmark) {
                Image(item.isBookmarked ? "bookMark" : "bookMarkEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .padding(10)
            }
            .contentShape(Rectangle())
            .glassEffect()
            .padding(6)
        }
    }
}

#Preview {
    CardView(item: MainCardItem(title: "My Entry", content: "Some text...")) {}
}
