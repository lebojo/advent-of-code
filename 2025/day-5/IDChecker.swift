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
	var res = 0

	let ranges = parsedInput[0].split(separator: "\n").compactMap { range -> ClosedRange<Int>? in
		let split = String(range).split(separator: "-")
		guard split.count == 2, let start = Int(split[0]), let end = Int(split[1]) else {
			return nil
		}
		return start...end
	}
	let ids = parsedInput[1].split(separator: "\n").compactMap { Int($0) }

	for id in ids {
		for range in ranges {
			if range.contains(id) {
				res += 1
				break
			}
		}
	}

	return res
}

print(IDChecker(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(IDChecker(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}
