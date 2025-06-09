//
//  ViewModel.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/9/25.
//

import Foundation

/**
 Extension containing the ViewModel for ContentView that handles article data management.
 */
extension ContentView {
	
	/**
	 Observable view model that manages article data loading and state for ContentView.
	 
	 Handles asynchronous fetching of articles from a remote API with automatic UI updates
	 through SwiftUI's observation system.
	 
	 Usage:
	 ```swift
	 @State private var viewModel = ContentView.ViewModel()
	 
	 // In view body or onAppear
	 await viewModel.loadArticles()
	 ```
	 */
	@Observable @MainActor
	class ViewModel {
		
		// MARK: - Properties
		
		/**
		 Array of loaded articles with private setter to maintain data integrity.
		 Updates automatically trigger UI refreshes in observing views.
		 */
		private(set) var articles: [Article] = []
		
		// MARK: - API Methods
		
		/**
		 Asynchronously loads articles from the remote API endpoint.
		 
		 Fetches article data from the HWS news API, decodes JSON with ISO8601 date handling,
		 and updates the articles array. Errors are logged to console.
		 
		 - Note: Must be called from a Task or async context
		 - Important: All UI updates happen on MainActor due to class annotation
		 */
		func loadArticles() async {
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
				
			} catch {
				// Log any networking or decoding errors
				print("Failed to load articles: \(error.localizedDescription)")
			}
		}
	}
}
