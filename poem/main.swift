//
//  main.swift
//  poem
//

import Foundation

let requestURL = URL(string: "https://m.poemhunter.com/1.0/poemList?listType=1")!

func getRandomPoemHTML() {

	let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
		if let error = error {
			print(error)
		}

		guard let response = response else { return }

		guard let data = data else { return }

		parseHTML(data: data)
	}

	task.resume()
}

func parseHTML(data: Data) {
	do {
		let poemResponse = try JSONDecoder().decode(PoemAPIResponse.self, from: data)
		let poem = poemResponse.response.items[0]

		print("""
			\(poem.title)
			by: \(poem.poetName)
			url: \(poem.poem_url)
			---

			\(poem.content)
			---

			""")

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(0)
	} catch {
		print("error")
	}
}

getRandomPoemHTML()
CFRunLoopRun()
