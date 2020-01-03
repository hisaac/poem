//
//  Poem.swift
//  poem
//

import Foundation

struct Poem: Decodable {
	let title: String
	let poemURL: URL
	let poetName: String
	let body: String
	let rate: Int
	let poetID: Int
	let date: String
	let poetPicture: URL
	let id: Int
	let about: [String]

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

struct PoemResponse: Decodable {
	let poems: [Poem]
	let title: String

	enum CodingKeys: String, CodingKey {
		case poems = "items"
		case title
	}
}

struct PoemAPIResponse: Decodable {
	let response: PoemResponse
	let success: Bool

	var poems: [Poem] {
		response.poems
	}
}

/*
Example response:

{
	"response": {
		"info": {},
		"items": [
			{
				"title": "Dialogue",
				"poem_url": "http://www.poemhunter.com/poem/dialogue/",
				"poetName": "Henry Livingston Jr.",
				"content": "Children\n\nPray dearest mother if you please\nCut up your double-curded cheese,\nThe oldest of the brotherhood.\nIt's ripe, no doubt and nicely good!\nYour reputation will rise treble\nAs we the lucious morsel nibble.\nPraise will flow from each partaker\nBoth on the morsel and the maker!\n\n\nMadame\n\nYour suit is vain,--upon my word,\nYou taste not yet my double-curd;\nI know the hour,--the very minute\nIn which I'll plunge my cutteau in it;\nAm I to learn of witless bairns\nHow I must manage my concerns?\nAs yet the fervid dog-star reigns\nAnd gloomy Virgo holds the reigns.\nBe quiet chicks, sedate and sober\nAnd house your stomachs till October;\nThen for a feast! Upon my word,\nI'll really cut my double curd.",
				"rate": 6,
				"poetId": 3154,
				"date": "2004-01-01T12:00:00 +02:00",
				"poetPicture": "http://img.poemhunter.com/p/54/3154_b_5180.jpg",
				"id": 384608,
				"about": [
					"october",
					"dog",
					"star",
					"house",
					"children"
				]
			},
			...
		],
		"title": ""
	},
	"success": true
}

*/
