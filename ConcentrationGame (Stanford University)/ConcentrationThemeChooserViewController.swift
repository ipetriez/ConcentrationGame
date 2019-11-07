//
//  ConcentrationThemeChooserViewController.swift
//  ConcentrationGame
//
//  Created by Sergey Petrosyan on 10/21/19.
//  Copyright © 2019 Sergey Petrosyan. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private enum Themes: String, CaseIterable {
        case halloween = "🎃👻🧛🏿‍♂️🦇👹☠️⚰️🧟‍♀️👽🕷"
        case animals = "🐒🐶🦊🐈🐱🐷🐸🐢🐼🦉"
        case sports = "🥎🏀🎱⚽️🏈🏐⚾️🎳🏓🏏"
        case barbie = "🦄💅👑👛👠⭐️🌸👸🏻💄🍭"
        case fruits = "🥭🍎🍐🍊🍋🍌🍉🍇🍒🍓"
        case sea = "🐙🦀🐡🐠🐬🐳🦈🐊🐟🐚"
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func ChangeTheme(_ sender: UIButton) {
        if let cvc = splitViewDetailConcentrationViewController {
            switch sender.currentTitle {
            case "Halloween theme":
                cvc.theme = Themes.halloween.rawValue
            case "Animals theme":
                cvc.theme = Themes.animals.rawValue
            case "Sports theme":
                cvc.theme = Themes.sports.rawValue
            case "Barbie theme":
                cvc.theme = Themes.barbie.rawValue
            case "Fruits theme":
                cvc.theme = Themes.fruits.rawValue
            case "Sea theme":
                cvc.theme = Themes.sea.rawValue
            default:
                break
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            navigationController?.pushViewController(cvc, animated: true)
            switch sender.currentTitle {
            case "Halloween theme":
                cvc.theme = Themes.halloween.rawValue
            case "Animals theme":
                cvc.theme = Themes.animals.rawValue
            case "Sports theme":
                cvc.theme = Themes.sports.rawValue
            case "Barbie theme":
                cvc.theme = Themes.barbie.rawValue
            case "Fruits theme":
                cvc.theme = Themes.fruits.rawValue
            case "Sea theme":
                cvc.theme = Themes.sea.rawValue
            default:
                break
            }
        }  else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let cvc = segue.destination as? ConcentrationViewController {
                    switch button.currentTitle {
                    case "Halloween theme":
                        cvc.theme = Themes.halloween.rawValue
                    case "Animals theme":
                        cvc.theme = Themes.animals.rawValue
                    case "Sports theme":
                        cvc.theme = Themes.sports.rawValue
                    case "Barbie theme":
                        cvc.theme = Themes.barbie.rawValue
                    case "Fruits theme":
                        cvc.theme = Themes.fruits.rawValue
                    case "Sea theme":
                        cvc.theme = Themes.sea.rawValue
                    default:
                        break
                    }
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
