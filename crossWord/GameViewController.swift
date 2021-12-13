//
//  GameViewController.swift
//  crossWord
//
//  Created by ZhenYu Niu on 2020-06-25.
//  Copyright © 2020 ZhenYu Niu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioToolbox

class GameViewController: UIViewController {
    
    var Gamestatus = false
    var luckNumberStatus = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var ScratchWordStatus = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var words = 0
    @IBOutlet weak var Startbutton: UIButton!
    var luckNum = ["","","","","","","","","","","","","","","","","",""]
    var prizzeAmount = [0,0,3,7,15,25,50,100,5000,10000,25000,50000]
    var Puzzle0 = ["","I","D","E","N","T","I","C","A","L","",
                       "","V","","L","","A","","H","","","D",
                       "","Y","","M","","M","","A","","","R",
                       "K","","T","","C","A","N","D","A","C","E",
                       "A","","H","","","R","","","L","","W",
                       "S","H","E","I","L","A","","E","B","B","",
                       "A","","O","","","","","","E","","T",
                       "N","U","D","G","E","","L","","R","O","Y",
                       "D","","O","","","M","A","T","T","","L",
                       "R","U","R","A","L","","D","","","","E",
                       "A","","E","","","M","Y","T","H","","R",
                       "B","A","T","T","E","R"]

    var Puzzle1 = ["","P","","","P","E","T","E","R","","",
                   "S","E","A","N","","","","R","","","G",
                   "","D","","E","","","B","A","S","I","L",
                   "D","I","V","I","D","E","","","E","","E",
                   "","C","","G","","","D","","R","U","N",
                   "R","U","T","H","","","E","","G","","",
                   "","R","","B","O","B","B","I","E","","T",
                   "","E","G","O","","","O","","A","","R",
                   "Z","","","U","","F","R","A","N","C","A",
                   "O","V","E","R","","","A","","T","","C",
                   "E","","","","J","O","H","N","","","Y",
                   "A","C","C","E","N","T"]
    var Puzzle2 = ["E","X","E","R","C","I","S","E","","Z","",
                   "","","","","E","","K","","C","O","Y",
                   "S","","G","O","A","L","I","E","","N","",
                   "A","","","","S","","S","","L","E","T",
                   "F","O","R","M","E","R","","","O","","R",
                   "E","","","A","","","","","A","","I",
                   "G","U","A","R","D","","P","E","D","A","L",
                   "U","","","S","","F","","V","","","L",
                   "A","","S","H","E","L","V","E","","","I",
                   "R","","","A","","I","","N","","","U",
                   "D","","","L","A","P","","","R","I","M",
                   "W","A","F","F","L","E"]
    
    var presstims = 0
    
    
    
    //==========================
    @IBOutlet var PuzzleBlock: [UIButton]!
      //==========================
    
    
    @IBOutlet weak var NumOfword: UILabel!
    @IBOutlet weak var prizze: UILabel!
    @IBAction func Start(_ sender: Any) {
        Startbutton.isHidden = true
        Gamestatus = true
        prizze.text = "    $0"
        NumOfword.text = "         Words"
        AudioServicesPlaySystemSound(1520);
        let random = createRandomMan(start: 65,end: 90)
        for i in 0...17{
            luckNum[i] = String(UnicodeScalar(random()!)!)
        }
        print(luckNum)
        let r = arc4random_uniform(3)
//        for a in 0...126{
//        PuzzleBlock[a].setTitle(Puzzle[a], for: UIControl.State())
//        }
        if r == 0 {
            for a in 0...126{
            PuzzleBlock[a].setTitle(Puzzle0[a], for: UIControl.State())
            }
        }else if r == 1{
            for a in 0...126{
            PuzzleBlock[a].setTitle(Puzzle1[a], for: UIControl.State())
            }
        }else if r == 2{
            for a in 0...126{
            PuzzleBlock[a].setTitle(Puzzle2[a], for: UIControl.State())
            }
        }
}
    
    @IBAction func luckword(_ sender: Any) {
        // var isCanScratch = true
        AudioServicesPlaySystemSound(1519);
        if luckNumberStatus[(sender.self as! UIButton).tag] == 0 && Gamestatus{
            (sender.self as AnyObject).setImage(UIImage(named: luckNum[presstims] + ".png"), for: UIControl.State())
            if presstims < 17{
            presstims = presstims + 1
            }
           luckNumberStatus[(sender.self as! UIButton).tag] = 1
        }
        
    }
    
    
    
    @IBAction func scratch(_ sender: Any) {
        
        if ScratchWordStatus[(sender as! UIButton).tag] == 0 && Gamestatus && (sender as! UIButton).currentTitle != ""{
            ScratchWordStatus[(sender as! UIButton).tag] = 1
            AudioServicesPlaySystemSound(1519);
            (sender as! UIButton).backgroundColor = UIColor.white
            let resultR = StartEndRow(button: (sender as! UIButton).tag)
            let resultC = StartEndColumn(button: (sender as! UIButton).tag)
            var CheckR = [Bool](repeating: false, count:resultR.count)
            var CheckC = [Bool](repeating: false, count:resultC.count)
            if resultR.count == 1 {
                for i in 0...resultC.count - 1 {
                    if(PuzzleBlock[resultC[i]].backgroundColor == UIColor.white  && luckNum.contains(PuzzleBlock[resultC[i]].currentTitle!) || PuzzleBlock[resultC[i]].backgroundColor == UIColor.red && luckNum.contains(PuzzleBlock[resultC[i]].currentTitle!)){
                        CheckC[i] = true
                    }
                }
                if CheckC.contains(false) == false{
                    for i in 0...resultC.count - 1{
                        PuzzleBlock[resultC[i]].backgroundColor = UIColor.red
                    }
                    showPrizze()


                }
            }else if resultC.count == 1{
                for i in 0...resultR.count - 1 {
                    if(PuzzleBlock[resultR[i]].backgroundColor == UIColor.white && luckNum.contains(PuzzleBlock[resultR[i]].currentTitle!) || PuzzleBlock[resultR[i]].backgroundColor == UIColor.red && luckNum.contains(PuzzleBlock[resultR[i]].currentTitle!)){
                        CheckR[i] = true
                    }
                }
                if CheckR.contains(false) == false{
                    for i in 0...resultR.count - 1{
                        PuzzleBlock[resultR[i]].backgroundColor = UIColor.red
                    }
                    showPrizze()

                }
            }else{
                for i in 0...resultC.count - 1 {
                    if(PuzzleBlock[resultC[i]].backgroundColor == UIColor.white  && luckNum.contains(PuzzleBlock[resultC[i]].currentTitle!) || PuzzleBlock[resultC[i]].backgroundColor == UIColor.red && luckNum.contains(PuzzleBlock[resultC[i]].currentTitle!)){
                        CheckC[i] = true
                    }
                }
                if CheckC.contains(false) == false{
                    for i in 0...resultC.count - 1{
                        PuzzleBlock[resultC[i]].backgroundColor = UIColor.red
                        
                    }
                    showPrizze()

                }
                for i in 0...resultR.count - 1 {
                    if(PuzzleBlock[resultR[i]].backgroundColor == UIColor.white  && luckNum.contains(PuzzleBlock[resultR[i]].currentTitle!) || PuzzleBlock[resultR[i]].backgroundColor == UIColor.red && luckNum.contains(PuzzleBlock[resultR[i]].currentTitle!)){
                        CheckR[i] = true
                    }
                }
                if CheckR.contains(false) == false{
                    AudioServicesPlaySystemSound(1521)
                    for i in 0...resultR.count - 1{
                        PuzzleBlock[resultR[i]].backgroundColor = UIColor.red
                    }
                    showPrizze()
                

                }
            }
            print(resultR)
            print(resultC)
            

        }
    }
    @IBOutlet var LuckWords: [UIButton]!
    @IBAction func Playagain(_ sender: Any) {
        Startbutton.isHidden=false
        presstims = 0
        Gamestatus = false
        for i in 0...luckNumberStatus.count-1{
            luckNumberStatus [i] = 0
            LuckWords[i].setImage(UIImage(named: "L" + String(i+1)  + ".png"), for: UIControl.State())
        }
        for i in 0...ScratchWordStatus.count-1{
            ScratchWordStatus [i] = 0
            PuzzleBlock[i].setTitle("", for: UIControl.State())
            PuzzleBlock[i].backgroundColor = UIColor.systemOrange
        }
        
//        gameStale = [0, 0, 0, 0, 0, 0, 0, 0, 0]
//        gameIsActive = true
//        for i in 1...9{
//            let button = view.viewWithTag(i) as! UIButton
//            button.setImage(nil, for: UIControl.State())
            
        //}
    }
    func showPrizze(){
        if words < 11 {
            words = words + 1
            prizze.text = "    $" + String(prizzeAmount[words])
            NumOfword.text = "      " + String(words) + " Words"
        }
    }
    
    func StartEndRow(button: Int) ->[Int] {
        var index = button
        var indexS = index
        var indexE = 0
        let EdgeLeft = [10,21,32,43,54,65,76,87,98,109,120,126]
        let EdgeRight = [0,11,22,33,44,55,66,77,88,99,110,121,]
        if button > 120 {
            indexS = 121
            indexE = 126
        }else{
            for _ in 0...11{
                 
                 if( PuzzleBlock[index - 1 ].currentTitle != "") {
                     let a = index - 1
                     if EdgeLeft.contains(a) == false {
                         index = index - 1
                     }
                 }
             }
            indexS = index
             for _ in 0...11{
                 if( PuzzleBlock[index + 1 ].currentTitle != "") {
                                let a = index + 1
                                if EdgeRight.contains(a) == false {
                                
                                    index = index + 1
                                }
                            }
             }
             indexE = index
        }
        
        let size = (indexE-indexS) + 1
        var Rindex = [Int](repeating: 0, count:size)
        Rindex[0] = indexS
        Rindex[size-1] = indexE
        for a in indexS...indexE{
           
            Rindex[a-indexS] = a
            
        }
        return Rindex
        
    }
    
    func StartEndColumn(button: Int) ->[Int]{
        var index = button
        var indexS = index
        var indexE = 0
        let EdgeTop = [0,1,2,3,4,5,6,7,8,9,10]
        let EdgeBottom = [120,119,118,117,116,115,114,113,112,111,110]
        var a = button
        var bouns = [Int](repeating: 0, count:1)
        if button <= 120 {
        if EdgeTop.contains(index){
            index = index + 11
        } else if EdgeBottom.contains(index){
            index = index - 11
        }

        
        for _ in 0...11{
            if(PuzzleBlock[index - 11].currentTitle != ""){
                a = index - 11
              
                if EdgeTop.contains(a) == false {
                    index = index - 11
                }
            }
        }
        indexS = a
        for _ in 0...11{
            if(PuzzleBlock[index + 11].currentTitle != ""){
                 a = index + 11
                if EdgeBottom.contains(a) == false {
                    index = index + 11
                }
            }
        }
        indexE = a
        let size = (indexE-indexS)/11 + 1
        var Cindex = [Int](repeating: 0, count:size)
        Cindex[0] = indexS
        
        if (indexS != indexE){
            Cindex[size-1] = indexE
            var tmp = -1
            for a in 1...size{
                if tmp < Cindex[size-1]{
                tmp = indexS + 11*a
                Cindex[a] = tmp
                }
            }
        }
        if(button>120){
            Cindex[0]=button
        }
        return Cindex
        }else {
            
            bouns[0]=button
        }
        return bouns
    }
    
    func createRandomMan(start: Int, end: Int) ->() ->Int? {
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
         
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            }else {
                //所有值都随机完则返回nil
                return nil
            }
        }
         
        return randomMan
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
