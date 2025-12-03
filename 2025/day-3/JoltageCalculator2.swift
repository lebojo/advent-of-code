import Foundation

let testInput = """
	987654321111111
	811111111111119
	234234234234278
	818181911112111
	"""

func joltageCalculator(_ input: String) -> Int {
	input.split(separator: "\n").reduce(0) { total, line in
		let nums = line.compactMap { $0.wholeNumberValue }
		var stack: [Int] = []

		for (i, num) in nums.enumerated() {
			while let last = stack.last, num > last,
				(stack.count - 1) + (nums.count - i) >= 12
			{
				stack.removeLast()
			}

			if stack.count < 12 {
				stack.append(num)
			}
		}

		return total + stack.reduce(0) { $0 * 10 + $1 }
	}
}

print(joltageCalculator(testInput))

do {
	let entryFile = try String(contentsOfFile: "input", encoding: .utf8)
	print("\(joltageCalculator(entryFile))")
} catch {
	print("error decoding file")
	fatalError()
}

// Brute force way lol:
// 		for a in 0..<lineSplit.count {
// 	for b in (a + 1)..<lineSplit.count {
// 		for c in (b + 1)..<lineSplit.count {
// 			for d in (c + 1)..<lineSplit.count {
// 				for e in (d + 1)..<lineSplit.count {
// 					for f in (e + 1)..<lineSplit.count {
// 						for g in (f + 1)..<lineSplit.count {
// 							for h in (g + 1)..<lineSplit.count {
// 								for i in (h + 1)..<lineSplit.count {
// 									for j in (i + 1)..<lineSplit.count {
// 										for k in (j + 1)..<lineSplit.count {
// 											for l in (k + 1)..<lineSplit.count {
// 												allPossibilities.append(
// 													Int(
// 														"\(lineSplit[a])\(lineSplit[b])\(lineSplit[c])\(lineSplit[d])\(lineSplit[e])\(lineSplit[f])\(lineSplit[g])\(lineSplit[h])\(lineSplit[i])\(lineSplit[j])\(lineSplit[k])\(lineSplit[l])"
// 													))
// 											}
// 										}
// 									}
// 								}
// 							}
// 						}
// 					}
// 				}
// 			}
// 		}
// 	}
// }
