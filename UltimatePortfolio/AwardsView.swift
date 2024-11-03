//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 03/11/2024.
//

import SwiftUI

struct AwardsView: View {
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            // MARK: More Later
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.secondary.opacity(0.5))
                        }
                    }
                }
            }
            .navigationTitle("Awards")
        }
    }
}

#Preview {
    AwardsView()
}
