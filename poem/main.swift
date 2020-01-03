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
			FileHandle.standardOutput.write(Data(poem.formattedOutput.utf8))
		} else {
			FileHandle.standardError.write(Data("Error retrieving poem".utf8))
		}

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(Int32(Process.TerminationReason.exit.rawValue))
	} catch {
		let errorDescription = "Error retrieving poem: \(error.localizedDescription)\n"
		FileHandle.standardError.write(Data(errorDescription.utf8))

		FileHandle.standardError.write(Data("Raw data received:\n".utf8))
		FileHandle.standardError.write(data)

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(Int32(Process.TerminationReason.uncaughtSignal.rawValue))
	}
}

getRandomPoemHTML()
CFRunLoopRun()
