//
//  Poem.swift
//  poem
//

import Foundation

struct Poem {
	let title: String
	let poemURL: URL
	let poetName: String
	let body: String
	let rate: Int?
	let poetID: Int?
	let date: String?
	let poetPicture: URL?
	let id: Int?
	let about: [String]?

	var formattedOutput: String {
		"""
		\(title)
		by: \(poetName)
		url: \(poemURL)
		---

		\(body)
		---

		"""
	}
}

extension Poem: Decodable {
	enum CodingKeys: String, CodingKey {
		case title
		case poemURL = "poem_url"
		case poetName
		case body = "content"
		case rate
		case poetID = "poetId"
		case date
		case poetPicture
		case id
		case about
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)
		poemURL = try container.decode(URL.self, forKey: .poemURL)
		poetName = try container.decode(String.self, forKey: .poetName)
		body = try container.decode(String.self, forKey: .body)
		rate = try container.decode(Int?.self, forKey: .rate)
		poetID = try container.decode(Int?.self, forKey: .poetID)
		date = try container.decode(String?.self, forKey: .date)
		poetPicture = try container.decode(URL?.self, forKey: .poetPicture)
		id = try container.decode(Int?.self, forKey: .id)
		about = try container.decode([String]?.self, forKey: .about)
	}
}
