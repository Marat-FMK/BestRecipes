//
//  SwiftUIView.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 22.08.2025.
//

import SwiftUI

struct TrendingShimmerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.primary50)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.secondary)
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.yellow.opacity(0.4))
                        .padding(5)
                }
                .frame(width: 60 , height: 25)
                .padding(10)
            }
            Text("LOADING. . .")
                .foregroundStyle(.gray)
                .frame( width: 220, height: 22, alignment: .leading)
            
            HStack {
                Circle()
                    .foregroundStyle(.gray)
                    .frame(width: 32, height: 32)
                
                Text("By team two               ")
                    .font(.system(size: 30))
                    .frame(width: 116, height: 17)
                    .redacted(reason: .placeholder)
            }
        }
        .frame(width: 280, height: 254)
        .shimmering()
    }
}



#Preview {
    TrendingShimmerView()
}
