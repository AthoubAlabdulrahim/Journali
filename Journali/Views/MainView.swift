//
//  MainView.swift
//  Journali
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()

    var body: some View {
        ZStack {
            
            LinearGradient(colors: [
                Color(red: 0.08, green: 0.08, blue: 0.08),
                .black
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

           
            VStack(alignment: .leading, spacing: 16) {
                header
                content
            }

            
            toolbar
            searchBar
        }
        .sheet(isPresented: $viewModel.isPresentingNewEntry) {
            NewEntrySheet(
                title: $viewModel.newTitle,
                content: $viewModel.newContent,
                onCancel: viewModel.resetForm,
                onSave: viewModel.saveNewEntry
            )
        }
    }

  
    private var header: some View {
        HStack {
            Text("Journal")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

 
    private var content: some View {
        Group {
            if viewModel.filteredAndSortedItems.isEmpty {
                VStack(spacing: 12) {
                    Image("openBook")
                    Text("Begin Your Journal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color("Purple"))
                        .offset(y: -80)
                    Text("Craft your personal diary, tap the plus icon to begin")
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .offset(y: -75)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.filteredAndSortedItems) { item in
                            SwipeableCard(onDelete: {
                                viewModel.deleteItem(id: item.id)
                            }) {
                                CardView(item: item) {
                                    viewModel.toggleBookmark(for: item.id)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100) // Leaves room for search bar
                }
            }
        }
    }

   
    private var toolbar: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 12) {
                    // Filter Button
                    Button {
                        withAnimation { viewModel.isShowingFilterMenu.toggle() }
                    } label: {
                        Image("filter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 8)
                    }

                    Divider()
                        .background(Color.white.opacity(0.25))
                        .frame(height: 20)

                    // Add Entry Button
                    Button {
                        viewModel.isPresentingNewEntry = true
                    } label: {
                        Image("plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 5)
                    }
                    
                }
                .glassEffect()
                .frame(width: 44, height: 44)
               .padding(.trailing, 45)
                .padding(.top, 16)
                .overlay(alignment: .topTrailing) {
                    if viewModel.isShowingFilterMenu {
                        FilterPanel(
                            currentMode: viewModel.sortMode,
                            currentFilter: viewModel.filterMode,
                            onSelectBookmarkOnly: {
                                viewModel.filterMode = .bookmarkedOnly
                                viewModel.sortMode = .bookmarkFirst
                                viewModel.isShowingFilterMenu = false
                            },
                            onSelectEntryDateAll: {
                                viewModel.filterMode = .all
                                viewModel.sortMode = .entryDateDesc
                                viewModel.isShowingFilterMenu = false
                            },
                            onDismissOutside: {
                                withAnimation {
                                    viewModel.isShowingFilterMenu = false
                                }
                            }
                        )
                        .offset(y: 54)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
            }
            Spacer()
        }
    }

   
    private var searchBar: some View {
        VStack {
            Spacer()
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white.opacity(0.9))
                       // .frame(width: 505, height: 50)

                    TextField("Search...", text: $viewModel.searchText)
                        .foregroundStyle(.white)
                        .textInputAutocapitalization(.never)

                    Image(systemName: "microphone")
                        .foregroundStyle(.white.opacity(0.9))
                }
             //   .glassEffect()
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .glassEffect()
                )

            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainView()
}

