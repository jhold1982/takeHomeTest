//
//  ContentView.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/2/25.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - Properties
	@State private var viewModel = ViewModel()
	
	
	// MARK: - View Body
    var body: some View {
		NavigationStack {
			List(viewModel.articles, rowContent: ArticleRow.init)
				.navigationTitle("Take Home Test")
				.navigationDestination(
					for: Article.self,
					destination: ArticleView.init
				)
		}
		.task(viewModel.loadArticles)
    }
	// MARK: - Functions
	
}

#Preview {
    ContentView()
}
