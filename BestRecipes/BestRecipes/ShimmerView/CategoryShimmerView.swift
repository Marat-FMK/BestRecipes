//
//  CategoryShimmerView.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 22.08.2025.
//

import SwiftUI



import SwiftUI

struct CategoryShimmerView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<4) { _ in
                    ZStack(alignment: .top) {
                        Circle()
                            .shimmering()
                            .foregroundStyle(.primary20)
                            .frame(width: 110, height: 110)
                            .zIndex(2)
                            .offset(y: -55)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.gray)
                                .frame(width: 150, height: 176)
                            
                            Text("LOADING. . .")
                                .font(.system(size: 25))
                                .foregroundStyle(.black)
                                .zIndex(1)
                                .shimmering()
                        }
                    }
                    .frame(width: 150, height: 291)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 291)
    }
}

#Preview {
    CategoryShimmerView()
}

//struct CategoryShimmerView: View {
//    var body: some View {
//        ZStack(alignment: .top) {
//            
//            Circle()
//                .foregroundStyle(.primary50)
//                .frame(width: 110, height: 110)
//                .zIndex(1)
//                .offset(y: -55)
//            
//            ZStack {
//                RoundedRectangle(cornerRadius: 16)
//                    .frame(width: 150, height: 176)
//                    .shimmering()
//                Text("      ")
//                    .font(.system(size: 25))
//                    .redacted(reason: .placeholder)
//                    .shimmering()
//                
//            }
//            .foregroundStyle(.gray)
//            
//        }
//        .frame(width: 150, height: 231)
//    }
//}
//
//#Preview {
//    CategoryShimmerView()
//}
