import Foundation

let testInput = """
	3-5
	10-14
	16-20
	12-18

	1
	5
	8
	11
	17
	32
	"""

func IDChecker(_ input: String) -> Int {
	let parsedInput = input.split(separator: "\n\n")
	guard parsedInput.count == 2 else { return 0 }

	let ranges = parsedInput[0].split(separator: "\n").compactMap { range -> ClosedRange<Int>? in
		let split = String(range).split(separator: "-")
		guard split.count == 2, let start = Int(split[0]), let end = Int(split[1]) else {
			return nil
		}
		return start...end
	}

	let sorted = ranges.sorted { $0.lowerBound < $1.lowerBound }
	if sorted.isEmpty { return 0 }

	var current = sorted[0]
	var total = 0

	for range in sorted.dropFirst() {
		if range.lowerBound <= current.upperBound {
			current = current.lowerBound...max(current.upperBound, range.upperBound)
		} else {
			total += current.count
			current = range
		}
	}

	total += current.count

	return total
}

print(IDChecker(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(IDChecker(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
