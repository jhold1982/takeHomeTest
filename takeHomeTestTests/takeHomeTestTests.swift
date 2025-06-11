//
//  takeHomeTestTests.swift
//  takeHomeTestTests
//
//  Created by Justin Hold on 6/11/25.
//

@testable import takeHomeTest
import Foundation
import Testing

@MainActor
struct takeHomeTestTests {

    @Test func viewModelStartsEmpty() async throws {
        
        let viewModel = ContentView.ViewModel()
        
        #expect(viewModel.articles.isEmpty, "There should be zero articles initially.")
        #expect(viewModel.loadState == .loading, "The view model should start in the loading state.")
    }
    
    @Test func viewModelLoadsArticles() async throws {
        
        let viewModel = ContentView.ViewModel()
        
        await viewModel.loadArticles()
        
        #expect(viewModel.articles.isEmpty == false, "There should be articles after loading.")
        #expect(viewModel.loadState == .loaded, "The view model should finish loading in the loaded state.")
    }

    @Test func viewModelFilteringFull() async throws {
        
        let viewModel = ContentView.ViewModel()
        await viewModel.loadArticles()
        
        #expect(viewModel.filteredArticles == viewModel.articles, "All articles should be included when no filter is applied.")
    }
    
    @Test func viewModelFilteringExact() async throws {
        
        let viewModel = ContentView.ViewModel()
        await viewModel.loadArticles()
        
        viewModel.filterText = viewModel.articles.first?.title ?? ""
        
        #expect(viewModel.filteredArticles.count == 1, "Filtering for exact article should only show 1 result.")
    }
    
    @Test func viewModelFilteringEmpty() async throws {
        
        let viewModel = ContentView.ViewModel()
        await viewModel.loadArticles()
        
        viewModel.filterText = "XXX ASDF XXX ASDF XXX"
        
        #expect(viewModel.filteredArticles.isEmpty, "Filtering for a non-existent string should return no results.")
    }
}
