import Foundation

var res = 0

let fileContent = try! String(contentsOfFile: "./input5", encoding: .utf8)

let splittedRules = fileContent.components(separatedBy: "BOULE")

splittedRules[1].split(separator: "\n").forEach { update in
	res += isCorrect(String(update), splittedRules[0].components(separatedBy: "\n")) ? 1 : 0
}

print("There's \(res) correct updates")

func isCorrect(_ update: String,_ rules: [String]) -> Bool {
	return true
}