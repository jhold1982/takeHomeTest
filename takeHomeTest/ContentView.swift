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
            
            switch viewModel.loadState {
                
            case .failed:
                LoadFailedView(
                    error: viewModel.loadError,
                    retry: viewModel.loadArticles
                )
                
            default:
                if viewModel.articles.isEmpty {
                    ProgressView("Loading...")
                        .controlSize(.extraLarge)
                } else {
                    List(viewModel.filteredArticles, rowContent: ArticleRow.init)
                        .navigationDestination(for: Article.self, destination: ArticleView.init)
                        .navigationTitle("Read Up")
                        .refreshable(action: viewModel.loadArticles)
                        .searchable(text: $viewModel.filterText, prompt: "Filter Articles")
                }
            }
		}
		.task(viewModel.loadArticles)
    }
}

#Preview {
    ContentView()
}
