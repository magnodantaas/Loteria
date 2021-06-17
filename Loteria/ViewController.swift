//
//  ViewController.swift
//  Loteria
//
//  Created by Magno Miranda Dantas on 13/04/21.
//

import UIKit

enum GameType: String {
    case megaSena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    
    while(result.count < total) {
        let randomNumber = Int(arc4random_uniform(UInt32(universe)) + 1)
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 42/255.0, green: 99/255.0, blue: 185/255.0, alpha: 1.0)], for: .normal)
        
        showNumbers(for: .megaSena)
    }
    
    func showNumbers(for type: GameType) {
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megaSena:
                game = 6>-<60
                balls.last!.isHidden = false
            case .quina:
                game = 5>-<80
                balls.last!.isHidden = true
        }
        
        for (index, game) in game.enumerated() {
            balls[index].setTitle(String(game), for: .normal)
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megaSena)
        default:
            showNumbers(for: .quina)
        }
    }
    
}

