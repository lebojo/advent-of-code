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

let startPosition = 50

func decode(input: String) -> Int {
	let split = input.split(separator: "\n")
	var turnCount = 0
	var actualPosition = startPosition

	for line in split {
		guard !line.isEmpty else { continue }
		let direction = line.first == "L" ? -1 : 1
		let force = line.dropFirst()

		actualPosition += direction * (Int(force) ?? 0)
		while actualPosition > 99 {
			actualPosition -= 100
		}
		while actualPosition < 0 {
			actualPosition = 100 - (-actualPosition)
		}
		if actualPosition == 0 {
			turnCount += 1
		}
	}
	return turnCount
}

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(decode(input: entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
