//
//  main.swift
//  poem
//

import Foundation
import SwiftSoup

let requestURL = URL(string: "https://w0.poemhunter.com/members/random-poem/")!

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
	guard let htmlString = String(data: data, encoding: .utf8) else { return }
	do {
		let document = try parse(htmlString)
		let poem = try document.select("div.poem")
		let title = try poem.select("h2").text()
		let text = try poem.select("p").html().replacingOccurrences(of: "<br>", with: "\n")
		let poet = try poem.select("div.poet").text()
		print("""
			\(title)
			by: \(poet)
			---

			\(text)

			""")

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(0)
	} catch Exception.Error(let type, let message) {
		print(message)
	} catch {
		print("error")
	}
}

getRandomPoemHTML()
CFRunLoopRun()
