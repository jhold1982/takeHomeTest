//
//  takeHomeTestTests.swift
//  takeHomeTestTests
//
//  Created by Justin Hold on 6/11/25.
//

// Import the main module with @testable to access internal members
@testable import takeHomeTest
import Foundation
import Testing

/// Test suite for ContentView.ViewModel functionality
/// Uses @MainActor to ensure all tests run on the main thread for UI-related operations
@MainActor
struct takeHomeTestTests {

    /// Tests the initial state of a newly created ViewModel
    /// Verifies that the ViewModel starts in a clean, predictable state
    @Test func viewModelStartsEmpty() {
        
        // Arrange: Create a new ViewModel instance with default initialization
        let viewModel = ContentView.ViewModel()
        
        // Assert: Verify initial state is empty and loading
        #expect(viewModel.articles.isEmpty, "There should be zero articles initially.")
        #expect(viewModel.loadState == .loading, "The view model should start in the loading state.")
    }
    
    /// Tests the article loading functionality using a mock network session
    /// Verifies that articles are loaded and state transitions correctly
    @Test func viewModelLoadsArticles() async throws {
        
        // Arrange: Create ViewModel with mock URL session to simulate network response
        let viewModel = try ContentView.ViewModel(session: createMockURLSession())
        
        // Act: Trigger the article loading process
        await viewModel.loadArticles()
        
        // Assert: Verify articles were loaded and state updated
        #expect(viewModel.articles.isEmpty == false, "There should be articles after loading.")
        #expect(viewModel.loadState == .loaded, "The view model should finish loading in the loaded state.")
    }

    /// Tests filtering behavior when no filter is applied
    /// Ensures all articles are visible when no search criteria is specified
    @Test func viewModelFilteringFull() async throws {
        
        // Arrange: Create ViewModel and load test data
        let viewModel = try ContentView.ViewModel(session: createMockURLSession())
        await viewModel.loadArticles()
        
        // Assert: When no filter is applied, all articles should be in filtered results
        #expect(viewModel.filteredArticles == viewModel.articles, "All articles should be included when no filter is applied.")
    }
    
    /// Tests filtering behavior with an exact title match
    /// Verifies that searching for a complete article title returns exactly one result
    @Test func viewModelFilteringExact() async throws {
        
        // Arrange: Create ViewModel, load data, and set filter to exact article title
        let viewModel = try ContentView.ViewModel(session: createMockURLSession())
        await viewModel.loadArticles()
        
        // Act: Set filter text to the title of the first article (using nil coalescing for safety)
        viewModel.filterText = viewModel.articles.first?.title ?? ""
        
        // Assert: Exact match should return exactly one article
        #expect(viewModel.filteredArticles.count == 1, "Filtering for exact article should only show 1 result.")
    }
    
    /// Tests filtering behavior when search criteria matches no articles
    /// Verifies that nonsensical search terms return empty results
    @Test func viewModelFilteringEmpty() async throws {
        
        // Arrange: Create ViewModel and load test data
        let viewModel = try ContentView.ViewModel(session: createMockURLSession())
        await viewModel.loadArticles()
        
        // Act: Set filter text to a string that definitely won't match any article
        viewModel.filterText = "XXX ASDF XXX ASDF XXX"
        
        // Assert: Non-matching filter should return no results
        #expect(viewModel.filteredArticles.isEmpty, "Filtering for a non-existent string should return no results.")
    }
    
    /// Helper function to create a mock URL session for testing
    /// Returns a URLSessionMock configured with sample article data
    /// - Returns: URLSessionMock instance with encoded article data
    /// - Throws: EncodingError if article data cannot be encoded
    func createMockURLSession() throws -> URLSessionMock {
        
        // Create test data using the example article
        let articles = [Article.example]
        
        // Configure JSON encoder to match expected API response format
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601  // Use ISO 8601 date format for consistency
        
        // Encode the articles array to JSON data
        let articleData = try encoder.encode(articles)
        
        // Return mock session that will respond with this encoded data
        return URLSessionMock(data: articleData)
    }
}
