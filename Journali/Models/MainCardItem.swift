//
//  MainCardItem.swift
//  Journal3
//
//  Created by Athoub Alabdulrahim on 04/05/1447 AH.
//
import Foundation

struct MainCardItem: Identifiable, Equatable {
    let id: UUID = UUID()
    let title: String
    let date: Date = Date()
    let content: String
    var isBookmarked: Bool = false
}
