//
//  PhotoDetailView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 04/07/2024.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var mapPosition: MapCameraPosition = .camera(.init(centerCoordinate: .init(latitude: 51.476852, longitude: -0.000500), distance: 10_000))
    let photo: Photo

    var body: some View {
        VStack {
            ScrollView {
                PhotoHeroView(photo: photo)
                if let tags = photo.tags {
                    PhotoTagsView(tags: tags, font: .subheadline)
                        .contentMargins(.horizontal, 10, for: .scrollContent)
                }

                Spacer()

                VStack(alignment: .leading) {
                    if let description = photo.description {
                        Text(description)
                            .font(.body)
                    }

                    if let latLong = photo.latLong {
                        Map(position: $mapPosition) {
                            Marker("Photo Location", systemImage: "camera.fill", coordinate: latLong)
                                .annotationTitles(.hidden)
                                .tint(.accent)
                        }
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .padding(10)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbarRole(.editor)
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            if let latLong = photo.latLong {
                mapPosition = .camera(.init(centerCoordinate: latLong, distance: 10_000))
            }
        }
    }
}


#Preview {
    NavigationStack {
        PhotoDetailView(photo: .dummy)
    }
}
