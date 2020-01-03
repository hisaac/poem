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
		let poemAPIResponse = try JSONDecoder().decode(PoemAPIResponse.self, from: data)

		if let poem = poemAPIResponse.poems.first {
			print(poem.formattedOutput)
		} else {
			print("Error retrieving poem")
		}

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(0)
	} catch {
		print("Error retrieving poem:", error.localizedDescription)
		print("Raw JSON:", String(data: data, encoding: .utf8) ?? "error converting JSON to string")
		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(1)
	}
}

getRandomPoemHTML()
CFRunLoopRun()
