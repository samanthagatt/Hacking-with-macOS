//
//  ViewController.swift
//  Cows and Bulls
//
//  Created by Samantha Gatt on 6/9/19.
//  Copyright © 2019 Samantha Gatt. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var guessTextField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var guesses: [String] = []
    var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
    }

    @IBAction func submitGuess(_ sender: Any) {
        let guess = guessTextField.stringValue
        guard guess.count == 4 else {
            return
        }
        guard Set(guess).count == 4 else {
            return
        }
        
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guess.rangeOfCharacter(from: badCharacters) == nil else {
            return
        }
        guessTextField.stringValue = ""
        guesses.append(guess)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        if guess == answer {
            let alert = NSAlert()
            alert.messageText = "You win!"
            alert.informativeText = "Congratulations! Press OK to play again."
            alert.runModal()
            startNewGame()
        }
    }
    
    func result(for guess: String) -> String {
        var cows = 0
        var bulls = 0
        for (i, letter) in guess.enumerated() {
            if answer[i] == letter {
                bulls += 1
            } else if answer.contains(letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
    
    func startNewGame() {
        guessTextField.stringValue = ""
        answer = ""
        guesses.removeAll()
        var numbers = Array(0...9)
        numbers.shuffle()
        for _ in 0..<4 {
            answer.append(String(numbers.removeLast()))
        }
        tableView.reloadData()
    }
}

private typealias TableViewDataSource = ViewController
extension TableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnID = tableColumn?.identifier,
            let cell = tableView.makeView(withIdentifier: columnID, owner: self) as? NSTableCellView else { return nil }
        let guess = guesses.itemAt(opposite: row)
        cell.textField?.stringValue = tableColumn?.title == "Guess" ? guess : result(for: guess)
        return cell
    }
}

private typealias TableViewDelegate = ViewController
extension TableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}
