import Foundation

let testInput = """
	L68
	L30
	R48
	L5
	R60
	L55
	L1
	L99
	R14
	L82
	"""  // Should give us 3

func decode(input: String) -> Int {
	let split = input.split(separator: "\n")
	var turnCount = 0
	var position = 50  // Position de 0 à 99

	for line in split {
		guard !line.isEmpty else { continue }

		let direction = line.first == "L" ? -1 : 1
		let moves = Int(line.dropFirst()) ?? 0

		for _ in 0..<moves {
			position += direction
			if position > 99 { position = 0 }  // Wrap 99 -> 0
			if position < 0 { position = 99 }  // Wrap 0 -> 99
			if position == 0 {
				turnCount += 1
			}
		}
	}
	return turnCount
}

print("\(decode(input: testInput))")

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(decode(input: entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
