import SwiftUI

struct BreedDetailSheet: View {
    let breed: Cat
    let isFavourite: Bool
    let toggleFavourite: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(breed.name ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button(action: toggleFavourite) {
                    Image(systemName: isFavourite ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundColor(isFavourite ? .black : .gray)
                        .padding()
                }
            }
            
            if let urlString = breed.image?.url, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if let origin = breed.origin {
                    Text("Origin: \(origin)")
                }
                
                if let temperament = breed.temperament {
                    Text("Temperament: \(temperament)")
                }
                
                if let description = breed.description {
                    Text("Description: \(description)")
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}
