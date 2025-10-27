//
//  NewEntry.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import SwiftUI

struct NewEntrySheet: View {
    @Binding var title: String
    @Binding var content: String
    var onCancel: () -> Void
    var onSave: () -> Void

    @State private var showDiscardAlert = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.08, green: 0.08, blue: 0.08), .black],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {
                header
                editor
            }
            .padding(16)
        }
        .alert("Discard Changes?", isPresented: $showDiscardAlert) {
            Button("Discard", role: .destructive) { onCancel() }
            Button("Keep Editing", role: .cancel) {}
        }
    }

    private var header: some View {
        HStack {
            Button { showDiscardAlert = true } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }

            Spacer()

            Button(action: onSave) {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color("Purple")))
            }
        }
    }

    private var editor: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .leading) {
                if title.isEmpty {
                    Text("Title")
                        .foregroundStyle(.white.opacity(0.5))
                        .font(.system(size: 22, weight: .semibold))
                }
                TextField("", text: $title)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .semibold))
            }

            Text(Date(), format: .dateTime.year().month().day())
                .font(.system(size: 14))
                .foregroundStyle(.white.opacity(0.7))

            ZStack(alignment: .topLeading) {
                if content.isEmpty {
                    Text("Type your Journal…")
                        .foregroundStyle(.white.opacity(0.5))
                        .font(.system(size: 18))
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }
                TextEditor(text: $content)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                    .frame(minHeight: 180)
                    .padding(.leading, -4)
            }
        }
    }
}

#Preview {
    NewEntrySheet(title: .constant(""), content: .constant(""), onCancel: {}, onSave: {})
}
