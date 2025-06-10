//
//  ArticleView.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/2/25.
//

import SwiftUI

struct ArticleView: View {
	
	// MARK: - Properties
	var article: Article
	
	
	
	// MARK: - View Body
	var body: some View {
		// Main scrollable container for the entire article content
		ScrollView {
			
            ArticleImageView(imageURL: article.image)
			
			VStack(alignment: .leading, spacing: 20) {
				Text(article.title)
					.font(.title) // Large, prominent title font
					.fontWeight(.bold) // Add emphasis to title
					.multilineTextAlignment(.leading) // Left-align for readability
				
				Text(article.description)
					.font(.headline) // Prominent but smaller than title
					.foregroundStyle(.secondary) // Subdued color for hierarchy
					.multilineTextAlignment(.leading) // Consistent alignment
				
				Divider()
					.padding(.vertical, 8) // Add vertical spacing around divider
				
				Text(article.text)
					.font(.body) // Standard readable body text font
					.lineSpacing(4) // Improved line spacing for readability
					.multilineTextAlignment(.leading) // Left-align for long-form content
			}
			.padding(.horizontal) // Horizontal padding for content margins
			.padding(.bottom) // Bottom padding for scroll content
		}
		// MARK: Navigation Configuration
		.navigationTitle(article.section) // Display article section as nav title
		.navigationBarTitleDisplayMode(.inline) // Compact title display mode
		.navigationBarBackButtonHidden(false) // Ensure back navigation is available
	}
}

#Preview {
	ArticleView(article: .example)
}
