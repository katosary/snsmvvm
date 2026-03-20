import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int // 評価（0〜5）
    var maxRating = 5

    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        rating = index // タップした星の番号を代入
                    }
            }
        }
    }
}
