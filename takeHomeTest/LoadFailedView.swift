//
//  LoadFailedView.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/10/25.
//

import SwiftUI

struct LoadFailedView: View {
    
    // MARK: - Properties
    var error: (any Error)?
    var retry: () async -> Void
    
    // MARK: - View Body
    var body: some View {
        
        ContentUnavailableView {
            Text("Load Error")
                .font(.headline)
        } description: {
            Text("There was an error.")
        } actions: {
            Button("Retry.") {
                Task {
                    await retry()
                }
            }
        }
    }
}

#Preview {
    LoadFailedView(error: NSError(domain: "TakeHomeTest", code: 1)) {
        // do nothing
    }
}
