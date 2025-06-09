//
//  ArticleImageView.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/9/25.
//

import SwiftUI

struct ArticleImageView: View {
	
	// MARK: - Properties
	var imageURL: URL
	
	
	// MARK: - View Body
    var body: some View {
        
		AsyncImage(url: imageURL) { phase in
			
			switch phase {
			case .empty:
				ProgressView()
			case .success(let image):
				image
					.resizable()
					.scaledToFit()
			default:
				Image(systemName: "newspaper")
			}
		}
    }
}

#Preview {
	ArticleImageView(imageURL: Article.example.image)
}
