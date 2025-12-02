import Foundation

let fileContent = try! String(contentsOfFile: "./input4", encoding: .utf8)

let matrixParsed = fileContent.split(separator: "\n").map { Array($0) }

let res1 = wordCounter(
	matrix: matrixParsed,
	word: "XMAS",
	directions: [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
)

var res2 = 0
matrixParsed.enumerated().forEach { (lineNumber, line) in
	guard lineNumber < matrixParsed.count - 1 && lineNumber >= 1 else { return }
	line.enumerated().forEach { (i, char) in
	guard i < matrixParsed[0].count - 1 && i >= 1 else { return }
		if char == "A" {
			if ("\(matrixParsed[lineNumber - 1][i - 1])A\(matrixParsed[lineNumber + 1][i + 1])" == "MAS" 
			|| "\(matrixParsed[lineNumber - 1][i - 1])A\(matrixParsed[lineNumber + 1][i + 1])" == "SAM") 
			&& 
			("\(matrixParsed[lineNumber + 1][i - 1])A\(matrixParsed[lineNumber - 1][i + 1])" == "MAS" 
			|| "\(matrixParsed[lineNumber + 1][i - 1])A\(matrixParsed[lineNumber - 1][i + 1])" == "SAM") {
				res2 += 1
			}
		}
	}
}

print("There's \(res1) XMAS, and \(res2) X-MAS")

func wordCounter(matrix: [[Character]], word: String, directions: [(Int, Int)]) -> Int {
	var count = 0
	matrix.enumerated().forEach { (lineNumber, line) in
		line.enumerated().forEach { (i, char) in
			if char == "X" {
				for dir in directions {
					count += directionnalWordCounter(matrix: matrix, word: word, position: (lineNumber + dir.0, i + dir.1), direction: dir, forNow: "X")
				}
			}
		}
	}
	return count
}

func directionnalWordCounter(matrix: [[Character]], word: String, position: (Int, Int), direction: (Int, Int), forNow: String) -> Int {
    guard (position.0 >= 0 && position.1 >= 0) && position.0 < matrix.count && position.1 < matrix[0].count else { return 0 }

    let newChar = matrix[position.0][position.1]
    let newForNow = "\(forNow)\(newChar)"
    
    if newForNow == word {
        return 1
    }
    if word.contains(newForNow) && newForNow.count > 1 {
        return directionnalWordCounter(matrix: matrix, word: word, position: (position.0 + direction.0, position.1 + direction.1), direction: direction, forNow: newForNow)
	}
	return 0
}