import Foundation

let testInput = """
	987654321111111
	811111111111119
	234234234234278
	818181911112111
	"""

func joltageCalculator(_ input: String) -> Int {
	let lines = input.split(separator: "\n")
	var total = 0

	for line in lines {
		guard !line.isEmpty && line.count > 1 else { continue }

		let lineSplit = line.split(separator: "").compactMap { Int($0) }
		var allPossibilities: [Int?] = []

		for i in 0..<lineSplit.count {
			for j in (i + 1)..<lineSplit.count {
				allPossibilities.append(Int("\(lineSplit[i])\(lineSplit[j])"))
			}
		}

		total += allPossibilities.compactMap(\.self).max() ?? 0
	}
	return total
}

print(joltageCalculator(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(joltageCalculator(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}

// I asked Gemini to transform my fonction in a more "swifty" way and it did:
// Educational purpose, still a nice catch! 👀
func joltageCalculatorGemini(_ input: String) -> Int {
	input.split(separator: "\n").reduce(0) { total, line in
		let digits = line.compactMap { $0.wholeNumberValue }

		// Crée toutes les paires possibles et trouve le max
		let maxPair =
			digits.indices.flatMap { i in
				digits[(i + 1)...].map { digits[i] * 10 + $0 }
			}.max() ?? 0

		return total + maxPair
	}
}
