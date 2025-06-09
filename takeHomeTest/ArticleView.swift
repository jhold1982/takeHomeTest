//
//  ArticleView.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/2/25.
//

import SwiftUI

import SwiftUI

/**
 A SwiftUI view that displays a detailed article with image, title, description, and full text content.
 
 `ArticleView` presents an article in a scrollable format with an asynchronously loaded header image,
 followed by the article's title, description, and body text. The view automatically handles image
 loading states and provides fallback content when images fail to load.
 
 ## Features
 - Asynchronous image loading with loading states
 - Responsive image scaling and layout
 - Hierarchical text styling for title, description, and body
 - Navigation integration with section-based title
 - Scrollable content for articles of any length
 
 ## Usage
 ```swift
 let sampleArticle = Article(
	 title: "Breaking News",
	 description: "Important updates from today",
	 text: "Full article content...",
	 section: "News",
	 image: URL(string: "https://example.com/image.jpg")
 )
 
 ArticleView(article: sampleArticle)
 ```
 
 - Important: The `Article` model must conform to the expected structure with `title`, `description`,
   `text`, `section`, and `image` properties.
 
 - Note: This view is designed to be presented within a `NavigationView` or `NavigationStack`
   to properly display the navigation title.
 
 - SeeAlso: `Article` model for the required data structure
 */
struct ArticleView: View {
	
	// MARK: - Properties
	var article: Article
	
	
	
	// MARK: - View Body
	var body: some View {
		// Main scrollable container for the entire article content
		ScrollView {
			
			// MARK: Header Image Section
			/**
			 Asynchronously loads and displays the article's header image.
			 Handles three states: loading, success, and failure with appropriate UI feedback.
			 */
			AsyncImage(url: article.image) { phase in
				switch phase {
				case .empty:
					// Display loading indicator while image is being fetched
					ProgressView()
						.frame(height: 200) // Consistent height during loading
					
				case .success(let image):
					// Successfully loaded image with responsive scaling
					image
						.resizable() // Makes image resizable
						.scaledToFill() // Fills available space while maintaining aspect ratio
						.frame(maxHeight: 300) // Limit maximum height for better layout
						.clipped() // Clip overflow content
					
				default:
					// Fallback content for failed image loads or other states
					Image(systemName: "newspaper")
						.font(.system(size: 60)) // Large, readable fallback icon
						.foregroundColor(.secondary) // Subtle color for fallback state
						.frame(height: 200) // Consistent height with loading state
				}
			}
			
			// MARK: Article Content Section
			/**
			 Vertical stack containing the article's textual content with proper spacing,
			 alignment, and typography hierarchy.
			 */
			VStack(alignment: .leading, spacing: 20) {
				
				// MARK: Article Title
				/**
				 Main article headline using title font style for maximum visual impact.
				 */
				Text(article.title)
					.font(.title) // Large, prominent title font
					.fontWeight(.bold) // Add emphasis to title
					.multilineTextAlignment(.leading) // Left-align for readability
				
				// MARK: Article Description
				/**
				 Article summary or subtitle using headline font with secondary styling
				 to create visual hierarchy below the main title.
				 */
				Text(article.description)
					.font(.headline) // Prominent but smaller than title
					.foregroundStyle(.secondary) // Subdued color for hierarchy
					.multilineTextAlignment(.leading) // Consistent alignment
				
				// MARK: Content Separator
				/**
				 Visual divider between description and main article body
				 to improve content organization and readability.
				 */
				Divider()
					.padding(.vertical, 8) // Add vertical spacing around divider
				
				// MARK: Article Body Text
				/**
				 Main article content using default body font for optimal readability
				 across different text lengths and device sizes.
				 */
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
