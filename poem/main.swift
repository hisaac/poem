//
//  main.swift
//  poem
//

import Foundation

let requestURL = URL(string: "https://m.poemhunter.com/1.0/poemList?listType=1")!

let stdout = FileHandle.standardOutput
let stderr = FileHandle.standardError
let arguments = CommandLine.arguments

func getRandomPoemHTML() {
	let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
		if let error = error {
			writeToStdErr(error.localizedDescription)
			exit(EXIT_FAILURE)
		}

		if let response = response as? HTTPURLResponse, response.statusCode != 200 {
			writeToStdErr("Server request was unsuccessful. Server responded with error code:", response.statusCode)
			exit(EXIT_FAILURE)
		}

		guard let data = data else {
			writeToStdErr("Unable to decode data")
			exit(EXIT_FAILURE)
		}

		parseHTML(data: data)
	}

	task.resume()
}

func parseHTML(data: Data) {
	do {
		let poemResponse = try JSONDecoder().decode(PoemResponse.self, from: data)

		if let poem = poemResponse.poems.first {
			writeToStdOut(poem.formattedOutput)
		} else {
			writeToStdErr("Error retrieving poem")
		}

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(EXIT_SUCCESS)
	} catch {
		writeToStdErr("Error retrieving poem:", error.localizedDescription)
		writeToStdErr("Raw data received:", data)

		CFRunLoopStop(CFRunLoopGetCurrent())
		exit(EXIT_FAILURE)
	}
}

func writeToStdOut(_ contentToWrite: Any...) {
	for content in contentToWrite {
		if content is String {
			FileHandle.standardOutput.write(Data("\(content)\n".utf8))
		} else if let data = content as? Data {
			FileHandle.standardOutput.write(data)
		}
	}
}

func writeToStdErr(_ contentToWrite: Any...) {
	for content in contentToWrite {
		if content is String {
			FileHandle.standardError.write(Data("\(content)\n".utf8))
		} else if let data = content as? Data {
			FileHandle.standardError.write(data)
		}
	}
}

getRandomPoemHTML()
CFRunLoopRun()
