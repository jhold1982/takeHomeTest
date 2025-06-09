//
//  ArticleRow.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/9/25.
//

import SwiftUI

struct ArticleRow: View {
	
	// MARK: - Properties
	var article: Article
	
	// MARK: - View Body
    var body: some View {
        
		
		NavigationLink(value: article) {
			
			HStack {
				
				ArticleImageView(imageURL: article.thumbnail)
					.frame(width: 80, height: 80)
					.clipShape(.rect(cornerRadius: 10))
				
				VStack(alignment: .leading) {
					Text(article.section)
						.font(.caption.weight(.heavy))
					
					Text(article.title)
				}
			}
		}
    }
}

#Preview {
	ArticleRow(article: .example)
}
