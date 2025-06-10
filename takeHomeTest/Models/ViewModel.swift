//
//  ViewModel.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/9/25.
//

import Foundation

extension ContentView {
    
    enum LoadState {
        case loading, loaded, failed
    }
	
	@Observable @MainActor
	class ViewModel {
		
        // MARK: - Properties
		private(set) var articles: [Article] = []
        
        private(set) var loadState = LoadState.loading
        private(set) var loadError: (any Error)?
        
        var filterText = ""
        
        var filteredArticles: [Article] {
            if filterText.isEmpty {
                articles
            } else {
                articles.filter {
                    $0.title.localizedStandardContains(filterText)
                }
            }
        }
		
        // MARK: - Functions
		func loadArticles() async {
            loadState = .loading
            
			do {
				// API endpoint for fetching articles
				let url = URL(string: "https://hws.dev/news")!
				
				// Fetch data from remote endpoint
				let (data, _) = try await URLSession.shared.data(from: url)
				
				// Configure JSON decoder for API response format
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601 // Handle ISO8601 date strings
				
				// Decode and update articles array (triggers UI update)
				articles = try decoder.decode([Article].self, from: data)
                loadState = .loaded
				
			} catch {
				// Log any networking or decoding errors
				print("Failed to load articles: \(error.localizedDescription)")
                loadState = .failed
                loadError = error
			}
		}
	}
}
