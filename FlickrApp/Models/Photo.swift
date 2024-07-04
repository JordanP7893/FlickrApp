//
//  Photo.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import CoreLocation
import Foundation

struct Photo: Identifiable {
    let id: String
    let title: String?
    let description: String?
    let owner: String
    let tags: [String]?
    let urlString: String
    let latLong: CLLocationCoordinate2D?

    var url: URL? {
        return URL(string: urlString)
    }

    init(
        id: String,
        title: String?,
        description: String? = nil,
        owner: String,
        tags: [String]? = nil,
        urlString: String,
        latLong: CLLocationCoordinate2D? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.owner = owner
        self.tags = tags
        self.urlString = urlString
        self.latLong = latLong
    }
}

extension Photo: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case owner = "ownername"
        case tags
        case urlString = "url_m"
        case latitude
        case longitude
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title).convertBlankToNil()
        description = ""
        owner = try container.decode(String.self, forKey: .owner)

        if let tagString = try container.decodeIfPresent(String.self, forKey: .tags) {
            tags = tagString.split(separator: " ").map { String($0) }
        } else {
            tags = nil
        }

        urlString = try container.decodeIfPresent(String.self, forKey: .urlString) ?? ""

        var latitude: Double?
        var longitude: Double?
        do {
            latitude = try container.decode(Double.self, forKey: .latitude)
        } catch {
            latitude = Double(try container.decode(String.self, forKey: .latitude))
        }

        do {
            longitude = try container.decode(Double.self, forKey: .longitude)
        } catch {
            longitude = Double(try container.decode(String.self, forKey: .longitude))
        }

        if let latitude, let longitude, latitude != 0 && longitude != 0 {
            latLong = .init(latitude: latitude, longitude: longitude)
        } else {
            latLong = nil
        }
    }
}

extension Photo {
    static var dummy: Self {
        .init(
            id: "53828846147",
            title: "Wood Storks",
            owner: "walterjeffords",
            tags: ["birds", "storks", "water", "nature"],
            urlString: "https://live.staticflickr.com/65535/53827544342_4beb3676a5.jpg",
            latLong: .init(latitude: 51, longitude: -0.000500)
        )
    }
}

extension Array where Element == Photo {
    static var dummyData: [Photo] {
        return [
            Photo(id: "53831638407", title: "", owner: "waynewalterberry", tags: ["nature", "lighthouse", "hilltop", "summer"], urlString: "https://live.staticflickr.com/65535/53831638407_a0a4b2b9d8.jpg"),
            Photo(id: "53831638912", title: "en_wordcloud.png", owner: "ujimasa", tags: ["screenshot"], urlString: "https://live.staticflickr.com/65535/53831638912_76768a5dbb.jpg"),
            Photo(id: "53831639917", title: "75e", owner: "infohomecop", urlString: "https://live.staticflickr.com/65535/53831639917_47d2ca4de0.jpg"),
            Photo(id: "53831640532", title: "Foto: Eduardo Barreto", owner: "Câmara Municipal de Vereadores", urlString: "https://live.staticflickr.com/65535/53831640532_2f0e7470bc.jpg"),
            Photo(id: "53831642507", title: "I’m not a plane spotter but I tried and I’ll just stick to buses and cars", owner: "daniel.grealish8", urlString: "https://live.staticflickr.com/65535/53831642507_b57d87f9eb.jpg"),
            Photo(id: "53831645747", title: "Comment_rester_en_bonne_santé_cet_été_(5)", owner: "dembuon89", urlString: "https://live.staticflickr.com/65535/53831645747_705e7d9fd5.jpg"),
            Photo(id: "53831646572", title: "Medal_cBSTVRts8Y", owner: "thiaggosampaio94", urlString: "https://live.staticflickr.com/65535/53831646572_305e2c7e67.jpg"),
            Photo(id: "53831646687", title: "", owner: "liba15", urlString: "https://live.staticflickr.com/65535/53831646687_e69b4b6e11.jpg"),
            Photo(id: "53831647572", title: "Visita ao CEU das Artes de Canoas, com a ministra Margareth Menezes e o ministro Waldez Goes", owner: "Ministro Paulo Pimenta", urlString: "https://live.staticflickr.com/65535/53831647572_1389202f7d.jpg"),
            Photo(id: "53831650692", title: "Bike freak + foamer = me.", owner: "john_pittman", urlString: "https://live.staticflickr.com/65535/53831650692_be7d395d89.jpg"),
            Photo(id: "53831653127", title: "Shoreham", owner: "looper23", urlString: "https://live.staticflickr.com/65535/53831653127_645abcfa4f.jpg"),
            Photo(id: "53831653357", title: "tongues of dull, fat Cerberus", owner: "A Yen for Phantoms", urlString: "https://live.staticflickr.com/65535/53831653357_4a6394c5e0.jpg"),
            Photo(id: "53831655002", title: "FiveM_b2944_GTAProcess_Hqy3ZDsXjv", owner: "rafaeldasilvaeduardo159", urlString: "https://live.staticflickr.com/65535/53831655002_cd9714da7d.jpg"),
            Photo(id: "53831655277", title: "Actually the main bell is named Big Ben.", owner: "phrenologist", urlString: "https://live.staticflickr.com/65535/53831655277_8cbf5c57e0.jpg"),
            Photo(id: "53831656717", title: "2024-07-02 16.49.37-1.jpg", owner: "gemories", urlString: "https://live.staticflickr.com/65535/53831656717_f7908505be.jpg"),
            Photo(id: "53831657737", title: "2024-07-03_04-16-51", owner: "mancrac", urlString: "https://live.staticflickr.com/65535/53831657737_d1fcbd39a6.jpg"),
            Photo(id: "53831658307", title: "Attraction", owner: "Wayne(小文)", urlString: "https://live.staticflickr.com/65535/53831658307_c69e230e88.jpg"),
            Photo(id: "53831658327", title: "Montana road trip expedition 1 - 2024", owner: "Lillard Fly Fishing Expeditions", urlString: "https://live.staticflickr.com/65535/53831658327_74f9782a4b.jpg"),
            Photo(id: "53831658807", title: "", owner: "igrejaabafloripa", urlString: "https://live.staticflickr.com/65535/53831658807_39a022357a.jpg"),
            Photo(id: "53831658852", title: "", owner: "National Park Trust", urlString: "https://live.staticflickr.com/65535/53831658852_bcac62e809.jpg"),
            Photo(id: "53831658897", title: "Il Lago di Carezza ©2024", owner: "stfpcc", urlString: "https://live.staticflickr.com/65535/53831658897_f2f5555510.jpg"),
            Photo(id: "53831659452", title: "Lighthouse vinduespudser", owner: "pegimana", urlString: "https://live.staticflickr.com/65535/53831659452_a98698472a.jpg"),
            Photo(id: "53831660827", title: "IMG_2437_kopie", owner: "Daniel_B.", urlString: "https://live.staticflickr.com/65535/53831660827_4eef2bbb9e.jpg"),
            Photo(id: "53831661827", title: "chrome_brX1Jlw1R3", owner: "irinaivanova010188", urlString: "https://live.staticflickr.com/65535/53831661827_075d227423.jpg"),
            Photo(id: "53832552156", title: "20240703_144745", owner: "blackcatmodelling", urlString: "https://live.staticflickr.com/65535/53832552156_644bba6b41.jpg"),
            Photo(id: "53832554066", title: "", owner: "kyeandtabbs", urlString: "https://live.staticflickr.com/65535/53832554066_00fe129432.jpg"),
            Photo(id: "53832554211", title: "", owner: "andyrossonline", urlString: "https://live.staticflickr.com/65535/53832554211_e14234f2e6.jpg"),
            Photo(id: "53832555891", title: "2024-07-03_09-09-51", owner: "mikepryor1", urlString: "https://live.staticflickr.com/65535/53832555891_e1bf7feb22.jpg"),
            Photo(id: "53832556666", title: "IMG-20240703-WA0056", owner: "mudugunarendra0", urlString: "https://live.staticflickr.com/65535/53832556666_9e7f44ef04.jpg"),
            Photo(id: "53832556821", title: "IMG-20240703-WA0036", owner: "contato@caoresort.com.br", urlString: "https://live.staticflickr.com/65535/53832556821_ba6d4cb53a.jpg"),
            Photo(id: "53832557041", title: "Daniel Le", owner: "Frank Mercurio", urlString: "https://live.staticflickr.com/65535/53832557041_4b2926eb33.jpg")
        ]
    }
}

