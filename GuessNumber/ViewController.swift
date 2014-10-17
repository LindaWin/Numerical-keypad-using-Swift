//
//  ViewController.swift
//  GuessNumber
//
//  Created by bladexuxiaolei on 14-10-15.
//  Copyright (c) 2014年 backpack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var keyBoard : KeyPad!
    var numbers : [NSInteger] = []
    var numbersLabel : UILabel!
    var numberSeg : UISegmentedControl!
    var hinLabel : UILabel!
    var inputBtn : UIButton!
    
    var maxNum = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLabel()
        createSeg()
        createhint()
        createinput()
            keyBoard = KeyPad(frame: getPos())
            keyBoard.borderColor = UIColor.GNColor().CGColor
            keyBoard.borderWidth = 2
            keyBoard.labelColor = UIColor.GNColor()
            keyBoard.labelText = "testKeyPad"
            keyBoard.labelFontSize = 32
            keyBoard.onButtonTouch = {(sender : UIButton) in self.test()}
            
       self.view.addSubview(keyBoard)
        
    }
    func createinput(){
        var width = self.view.frame.width/4
        var height = width/2
        var x = self.view.frame.width*0.5-width*0.5
        var y = self.view.frame.height*0.45
        inputBtn = UIButton(frame: CGRectMake(x, y, width, height))
        inputBtn.backgroundColor = UIColor.GNColor()
        inputBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        inputBtn.setTitleColor(UIColor.GNColor(), forState: UIControlState.Highlighted)
        inputBtn.setTitle("Go!", forState: UIControlState.Normal)
        
        self.view.addSubview(inputBtn)
    }
    func createhint(){
        var width = self.view.frame.width/4
        var height = width/3
        var x = self.view.frame.width*0.2
        var y = self.view.frame.height*0.35
        hinLabel = UILabel(frame: CGRectMake(x, y, width, height))
        hinLabel.textColor = UIColor.GNColor()
        hinLabel.backgroundColor = UIColor.clearColor()
        hinLabel.font = UIFont.systemFontOfSize(15)
        hinLabel.text = "选择游戏范围"
        self.view.addSubview(hinLabel)
    }
    func createSeg(){
        var width = self.view.frame.width/4
        var height = width/3
        var x = self.view.frame.width*0.6
        var y = self.view.frame.height*0.35
        numberSeg = UISegmentedControl(frame: CGRectMake(x, y, width, height))
        numberSeg.insertSegmentWithTitle("100", atIndex: 0, animated: true)
        numberSeg.insertSegmentWithTitle("1000", atIndex: 1, animated: true)
        numberSeg.setEnabled(true, forSegmentAtIndex: 1)
        numberSeg.tintColor = UIColor.GNColor()
        self.view.addSubview(numberSeg)
    }
    func createLabel(){
        var width = self.view.frame.width/3
        var height = width/2
        var x = self.view.frame.width*0.5 - width*0.5
        var y = self.view.frame.height*0.2
        numbersLabel = UILabel(frame: CGRectMake(x, y, width, height))
        numbersLabel.backgroundColor = UIColor.GNColor()
        numbersLabel.textAlignment = NSTextAlignment.Center
        numbersLabel.font = UIFont.systemFontOfSize(32.0)
        numbersLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(numbersLabel)
    }
    func getPos()->CGRect{
        var width = self.view.frame.width
        var height = self.view.frame.height*0.5
        var x = 0.5*self.view.frame.width-0.5*width
        var y = self.view.frame.height - height
        var rect = CGRectMake(x, y, width, height)
        return rect
    }
    func displayNum(){
        if self.keyBoard.thatNum != -1
        {
            numbers.insert(self.keyBoard.thatNum, atIndex: numbers.count)
            var tempstr = ""
            for i in 0...numbers.count-1
            {
                tempstr += NSString(format: "%d", numbers[i])
            }
            numbersLabel.text = tempstr
        }
        else if numbers.count != 0 {
            numbers.removeLast()
            if numbers.count != 0
            {
                var tempstr = ""
                for i in 0...numbers.count-1
                {
                    tempstr += NSString(format: "%d", numbers[i])
                }
                numbersLabel.text = tempstr
            }
            else{ numbersLabel.text = ""}
        }
        else{}
    }
    func test(){
        maxNum = numberSeg.selectedSegmentIndex+3
        displayNum()
        
    }
    override func viewDidLayoutSubviews() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

