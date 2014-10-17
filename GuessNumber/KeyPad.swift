//
//  KeyPad.swift
//  GuessNumber
//
//  Created by bladexuxiaolei on 14-10-16.
//  Copyright (c) 2014年 backpack. All rights reserved.
//

import UIKit

@IBDesignable class KeyPad: UIView {

    var buttons:[UIButton] = []
    var layers: [CALayer] = []
    var itemSize:CGFloat = 0.0
    var itemSizey:CGFloat = 0.0
    var whichNum = -1
    var thatNum = -2
    typealias buttonTouchInsideEvent = (sender: UIButton) -> ()
    var onButtonTouch: buttonTouchInsideEvent!
    let animationDuration = 0.15

    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)
        self.setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    @IBInspectable var borderColor: CGColor! {
        didSet {
            for i in 0...10{
                self.layers[i].borderColor = borderColor

            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 50 {
        didSet {
            for i in 0...10{
                self.layers[i].borderWidth = borderWidth
                
            }
        }
    }
    
    @IBInspectable var borderCornerRadius: CGFloat = 0.0 {
        didSet {
            for i in 0...10{
                self.layers[i].cornerRadius = borderCornerRadius
                
            }
        }
    }
    
    @IBInspectable var labelColor: UIColor = UIColor.blueColor() {
        didSet {
            for i in 0...10{
                self.buttons[i].setTitleColor(labelColor, forState: .Normal)
                self.buttons[i].setTitleColor(UIColor.whiteColor(), forState: .Selected)

            }
        }
    }
    
    @IBInspectable var labelText: String = "Default" {
        didSet {
            for i in 0...9{
                self.buttons[i].setTitle(NSString(format: "%d", (i+1)%10), forState: .Normal)
            }
            self.buttons[10].setTitle("del", forState: .Normal)
        }
    }
    
    @IBInspectable var labelFontSize: CGFloat = 11.0 {
        didSet {
            for i in 0...10{
                self.buttons[i].titleLabel?.font = UIFont.systemFontOfSize(labelFontSize)
            }
        }
    }
    
    
    
    func setup(){
        createNumLayer()
        createNumBtn()
        self.userInteractionEnabled = true
        for i in 0...10{
            self.buttons[i].addTarget(self, action: "onPress:", forControlEvents: .TouchDown)
            self.buttons[i].addTarget(self, action: "onRealPress:", forControlEvents: .TouchUpInside)
            self.buttons[i].addTarget(self, action: "onReset:", forControlEvents: .TouchUpInside)
            self.buttons[i].addTarget(self, action: "onReset:", forControlEvents: .TouchUpOutside)
            self.buttons[i].addTarget(self, action: "onReset:", forControlEvents: .TouchDragExit)
            self.buttons[i].addTarget(self, action: "onReset:", forControlEvents: .TouchCancel)
            whichNum = i
        }

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.borderColor = UIColor.blueColor()
        //self.labelColor = UIColor.GNColor()
        //self.borderWidth = 5
        //self.borderCornerRadius = 5.0
        //self.labelFontSize = 11.0
        
    }

    func createNumLayer(){
        itemSize = 6*self.layer.frame.width/25 as CGFloat
        itemSizey = self.layer.frame.height*5/26 as CGFloat
        var xposition = self.layer.frame.width/4 as CGFloat
        var yposition = self.layer.frame.height/5 as CGFloat
        for i in 0...9{
            layers.insert(CALayer(), atIndex: i)
            layers[i] = CALayer()
            layers[i].frame.size.width = itemSize
            layers[i].frame.size.height = itemSizey
            layers[i].position.x = CGFloat(i%3+1)*xposition
            layers[i].position.y = CGFloat(i/3+1)*yposition
            self.layer.addSublayer(layers[i])
        }
        layers.insert(CALayer(), atIndex: 10)
        layers[10].frame.size.width = itemSize*2
        layers[10].frame.size.height = itemSizey
        layers[10].position.x = 2.5*xposition
        layers[10].position.y = 4*yposition
        self.layer.addSublayer(layers[10])
    }
    func createNumBtn(){
        for i in 0...10{
            buttons.insert(UIButton(frame: self.layers[i].frame), atIndex: i)
            //println(buttons[0].frame.size)
            self.addSubview(buttons[i])
        }
    }
    func onPress(sender: AnyObject) {
        for i in 0...10{
            if buttons[i] == sender as NSObject{
                whichNum = i
                
            }
            if whichNum == 10{
                thatNum = -1
            }
            else if whichNum == -1
            {
                thatNum = -2
            }
            else
            {
                thatNum = (whichNum+1)%10
            }
        }
        UIView.animateWithDuration(self.animationDuration, animations: {
            self.buttons[self.whichNum].backgroundColor = self.labelColor
        })
        UIView.animateWithDuration(self.animationDuration, animations: {
            self.buttons[self.whichNum].backgroundColor = UIColor.clearColor()
        })
    }
    
    func onReset(sender: AnyObject) {
        UIView.animateWithDuration(self.animationDuration, animations: {
            self.buttons[self.whichNum].backgroundColor = UIColor.clearColor()
        })
    }
    
    func onRealPress(sender: AnyObject) {
        self.onButtonTouch(sender: sender as UIButton)
    }
}
