//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 03/11/2024.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    
    @State private var selectedAward: Award = .example
    @State private var isShowingAwardDetails: Bool = false
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            isShowingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5))
                        }
                    }
                }
            }
            .navigationTitle("Awards")
            .alert(awardTitle, isPresented: $isShowingAwardDetails) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(selectedAward.description)
            }
        }
    }
    
    var awardTitle: String {
        if dataController.hasEarned(award: selectedAward) {
            return "Unlocked \(selectedAward.name)"
        } else {
            return "Locked"
        }
    }
}

#Preview {
    AwardsView()
        .environmentObject(DataController.preview)
}