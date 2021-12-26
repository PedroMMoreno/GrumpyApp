//
//  ViewController.swift
//  GrumpyApp
//
//  Created by Pedro Moreno on 29/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var background: GradientView!
    @IBOutlet weak var emoji: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var speech: UIImageView!
    
    @IBOutlet weak var redButton: UIButton!
    
    private var counter: Int!
    
    private let emotions: Array<String> = ["thinking-1", "angry-3", "angry-1", "angry-2", "shocked-2", "disappointed", "crying", "angry", "skull"]
    private let gradientColours: Array<(startcolor: String, endcolor: String)> = [("#78ffd6ff","#a8ff78ff"), ("#38ef7dff","#11998eff"), ("#6be585ff","#dd3e54ff"), ("#f5af19ff","#f12711ff"), ("#6be585ff","#f5af19ff"),   ("#da4453ff","#89216bff"), ("#302b63ff","#0f0c29ff"), ("#eb5757ff","#000000ff"), ("#434343ff","#000000ff")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0
    }
    
    @IBAction func redButtonTouched(_ sender: UIButton) {
        sender.setImage(UIImage(named: "button_pressed.png"), for: .normal)
    }
    
    @IBAction func redButtonPressed(_ sender: UIButton) {
        counter += 1
        handleStates()
        sender.setImage(UIImage(named: "button.png"), for: .normal)
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        sender.setImage(UIImage(named: "reset_pressed.png"), for: .normal)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        counter = 0
        speech.isHidden = false
        emoji.isHidden = false
        redButton.isHidden = false
        label.textColor = UIColor.black
        handleStates()
        sender.setImage(UIImage(named: "reset.png"), for: .normal)
    }
    
    func handleStates(){
        var labelText = ""
        switch counter {
        case 0:
            labelText = "Don't press the button"
        case 1:
            labelText = "I told you not to press the button!"
        case 2:
            labelText = "HEY! DON'T YOU DARE!"
        case 3:
            labelText = "C'MON!"
        case 4:
            labelText = ""
            speech.isHidden = true
        case 5:
            labelText = ""
        case 6:
            labelText = ""
        case 7:
            speech.isHidden = false
            label.textColor = UIColor.white
            labelText = "OK...Bye World"
        case 8:
            labelText = ""
            speech.isHidden = true
            redButton.isHidden = true
        default:
            labelText = "Don't press the button"
        }
        changeLabel(text: labelText)
        changeEmoji(index: counter)
        handleBackground()
    }
    
    
    
    func changeLabel(text: String){
        label.text = text
    }
    
    func changeEmoji(index: Int){
        var imageFile: String = emotions[index]
        imageFile.append(".png")
        
        emoji.image = UIImage(named:imageFile)
    }
    
    func handleBackground(){
        background.startColor = UIColor(hex: gradientColours[counter].startcolor)!
        background.endColor = UIColor(hex: gradientColours[counter].endcolor)!
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}



