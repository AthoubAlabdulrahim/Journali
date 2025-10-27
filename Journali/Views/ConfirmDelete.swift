//
//  ConfirmDelete.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import SwiftUI

struct ConfirmDeleteOverlay: View {
    var onCancel: () -> Void
    var onDelete: () -> Void

    var body: some View {
        ZStack {

            VStack(alignment: .leading, spacing: 14) {
                Text("Delete Journal?")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)

                Text("Are you sure you want to delete this journal?")
                    .font(.system(size: 16))
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.leading)

                HStack(spacing: 12) {
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color.white.opacity(0.25)))
                    }

                    Button(action: onDelete) {
                        Text("Delete")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color.red))
                    }
                }
            }
            .padding(18)
            .frame(maxWidth: 340)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.white.opacity(0.12))
            )
            .shadow(color: .black.opacity(1), radius: 20, x: 0, y: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 👈 Forces centering
            .contentShape(Rectangle())
        }
        .transition(.opacity.combined(with: .scale))
        .animation(.easeInOut, value: true)
    }
}

#Preview {
    ConfirmDeleteOverlay(onCancel: {}, onDelete: {})
        .background(Color.black) // Just for preview visibility
}
