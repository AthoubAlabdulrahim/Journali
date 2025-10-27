//
//  SwipeableCard.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import SwiftUI

struct SwipeableCard<Content: View>: View {
    let onDelete: () -> Void
    @ViewBuilder var content: Content

    @GestureState private var dragOffset: CGFloat = 0
    @State private var positionX: CGFloat = 0
    @State private var showConfirm: Bool = false

    private let revealThreshold: CGFloat = 90
    private let maxReveal: CGFloat = 120

    private var progress: CGFloat {
        let total = positionX + dragOffset
        return min(max(total, 0), maxReveal) / maxReveal
    }

    var body: some View {
        ZStack {
            // Background: red delete capsule
            ZStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    Image(systemName: "trash.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .frame(height: 40)
                        .background(Capsule().fill(Color.red))
                        .opacity(progress)
                        .padding(.trailing, 16)
                }
            }
            .allowsHitTesting(false)

            // Foreground
            content
                .offset(x: -(positionX + dragOffset))
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .updating($dragOffset) { value, state, _ in
                            state = min(max(-value.translation.width, 0), maxReveal)
                        }
                        .onEnded { value in
                            let pull = max(-value.translation.width, 0)
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                if pull > revealThreshold {
                                    positionX = revealThreshold
                                    showConfirm = true
                                } else {
                                    positionX = 0
                                }
                            }
                        }
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.9), value: positionX)
                .overlay {
                    if showConfirm {
                        ConfirmDeleteOverlay(
                            onCancel: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                    showConfirm = false
                                    positionX = 0
                                }
                            },
                            onDelete: {
                                showConfirm = false
                                onDelete()
                            }
                        )
                    }
                }
            //    .glassEffect()
        }
    }
}

#Preview {
    SwipeableCard(onDelete: {}) {
        CardView(item: MainCardItem(title: "Note", content: "Swipe me")) {}
    }
}
