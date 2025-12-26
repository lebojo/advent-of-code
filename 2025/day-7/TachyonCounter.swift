import Foundation

let testInput = """
	.......S.......
	...............
	.......^.......
	...............
	......^.^......
	...............
	.....^.^.^.....
	...............
	....^.^...^....
	...............
	...^.^...^.^...
	...............
	..^...^.....^..
	...............
	.^.^.^.^.^...^.
	...............
	"""

struct Cursor: Hashable {
	var column: Int = 0
	var line: Int = 0
}

func TachyonCounter(_ input: String) -> Int {
	let parsedInput = input.split(separator: "\n")
	// let limits = Cursor(column: parsedInput.first?.count ?? 0, line: parsedInput.count)
	var beamPositions: Set<Cursor> = []
	var splitCount = 0

	for line in parsedInput.enumerated() {
		for i in line.element.enumerated() {
			if i.element == "S" {
				beamPositions.insert(Cursor(column: i.offset, line: line.offset + 1))
			}

			if beamPositions.contains(Cursor(column: i.offset, line: line.offset - 1)) {
				if i.element == "^" {
					splitCount += 1
					beamPositions.insert(Cursor(column: i.offset - 1, line: line.offset))
					beamPositions.insert(Cursor(column: i.offset + 1, line: line.offset))
				} else if i.element == "." {
					beamPositions.insert(Cursor(column: i.offset, line: line.offset))
				}
			}
		}
	}

	return splitCount
}

print(TachyonCounter(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(TachyonCounter(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
