//
//  Article.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/2/25.
//

import Foundation

// Codable: So we cna create articles from JSON

// Hashable: Use articles as navigation values in SwiftUI

// Identifiable: Loop over articles in SwiftUI based on identifier

struct Article: Codable, Hashable, Identifiable {
	
	let id: String
	var title: String
	var text: String
	
	var description: String
	var thumbnail: URL
	var date: Date
	var author: String

	var section: String
	var image: URL
	var url: URL
	
	static let example = Article(
		id: "1",
		title: "Apple buys Hacking with Swift",
		text: "In a move that shocked everyone, especially Tim Cook and Paul Hudson, Apple bought hackingwithswift.com.",
		description: "What a way to spend $10 million!",
		thumbnail: URL(string: "https://hws.dev/img/logo.png")!,
		date: .now,
		author: "Not Paul Hudson",
		section: "News",
		image: URL(string: "https://hws.dev/img/logo.png")!,
		url: URL(string: "https://www.hackingwithswift.com")!
	)
}
