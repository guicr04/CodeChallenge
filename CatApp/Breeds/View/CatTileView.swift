import SwiftUI

struct CatTileView: View {
    let breed: String
    let isFavourite: Bool
    let toggleFavourite: () -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(Image(systemName: "photo"))
                    
                Button(action: toggleFavourite) {
                        Image(systemName: isFavourite ? "star.fill" : "star")
                            .foregroundColor(isFavourite ? .black: .gray)
                            .padding(5)
                }
            }
            Text(breed)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
                .padding(.top, 4)
        }
        .frame(height: 180) // ✅ force consistent tile height
        .padding(5)
    }
}
