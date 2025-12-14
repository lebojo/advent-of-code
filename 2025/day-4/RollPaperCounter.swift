import Foundation

let testInput = """
	..@@.@@@@.
	@@@.@.@.@@
	@@@@@.@.@@
	@.@@@@..@.
	@@.@@@@.@@
	.@@@@@@@.@
	.@.@.@.@@@
	@.@@@.@@@@
	.@@@@@@@@.
	@.@.@@@.@.
	"""

func RollPaperCounter(_ input: String) -> Int {
	let lines = input.split(separator: "\n")
	let matrix = lines.map { $0.split(separator: "") }
	var res = 0

	for line in matrix.enumerated() {
		for rollIndex in line.element.enumerated() {
			guard rollIndex.element == "@" else { continue }
			var aroundRolls = 0
			for row in -1...1 {
				guard line.offset - row >= 0 && line.offset - row < lines.count else { continue }
				let actualRow = Array(lines[line.offset - row])
				let startColumn = rollIndex.offset > 0 ? rollIndex.offset - 1 : 0
				let inc = rollIndex.offset == 0 ? 2 : 3

				aroundRolls += actualRow[
					startColumn..<min(startColumn + inc, actualRow.count)
				].count {
					$0 == "@"
				}
			}

			if (aroundRolls - 1) < 4 {  // Minus one cause the current roll checked
				res += 1
			}
		}
	}
	return res
}

print(RollPaperCounter(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(RollPaperCounter(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
