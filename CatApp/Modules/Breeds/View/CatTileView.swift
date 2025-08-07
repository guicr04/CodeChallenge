import SwiftUI

struct CatTileView: View {
    let breed: Cat
    let isFavourite: Bool
    let toggleFavourite: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                if let urlString = breed.image?.url, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .background(Color.gray.opacity(0.2))
                    }
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(Image(systemName: "photo"))
                }
                    
                Button(action: toggleFavourite) {
                        Image(systemName: isFavourite ? "star.fill" : "star.fill")
                            .font(.system(size: 15))
                            .foregroundColor(isFavourite ? .black: .white.opacity(0.5))
                            .padding(6)
                }
                .accessibilityIdentifier("favouriteButton")
            }
            Text(breed.name!)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity, minHeight: 20, alignment: .top) //reserve space for 2 lines
                .padding(.top, 4)
                .accessibilityIdentifier("catTile")
        }
        .accessibilityIdentifier("catTile")
        .frame(height: 120) // ✅ force consistent tile height
        .padding(5)
    }
        
}
