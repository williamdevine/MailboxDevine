//
//  ViewController.swift
//  MailboxDevine
//
//  Created by WilliamDevine on 9/27/14.
//  Copyright (c) 2014 WilliamDevine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet var edgeGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    var imageCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(320,2080)
        self.msgView.backgroundColor = UIColor.grayColor()
        laterIcon.alpha = 0
        deleteIcon.alpha = 0
        archiveIcon.alpha = 0
        listIcon.alpha = 0
        rescheduleImage.alpha = 0
        listImage.alpha = 0
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.translationInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            println("pan began")
            
            imageCenter = messageImageView.center
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("pan changed")
            println(messageImageView.center.x)

            messageImageView.center.x = translation.x + imageCenter.x
            deleteIcon.center.x = translation.x - 30
            laterIcon.center.x = translation.x + 350
            archiveIcon.center.x = translation.x - 30
            listIcon.center.x = translation.x + 350

            
            // SWIPE LEFT. Turning the background yellow and showing the later icon
            
            if (messageImageView.center.x <= 100) {
                println("omg1")
                laterIcon.alpha = 1
                listIcon.alpha = 0

                msgView.backgroundColor = UIColor.yellowColor()
            }
            //SWIPE LEFT. Turning the background brown and showing the later icon
            if (messageImageView.center.x <= 0) {
                println("omg2")
                laterIcon.alpha = 0
                listIcon.alpha = 1
                msgView.backgroundColor = UIColor.brownColor()
            }
            // SWIPE RIGHT. Turning the background Green and showing delete icon
            
            if (messageImageView.center.x >= 220) {
                println("omg3")
                archiveIcon.alpha = 1
                deleteIcon.alpha = 0
                msgView.backgroundColor = UIColor.greenColor()

            }
            // SWIPE RIGHT. Turning the background Red and showing delete icon

            if (messageImageView.center.x >= 320) {
                println("omg3")
                archiveIcon.alpha = 0
                deleteIcon.alpha = 1
                msgView.backgroundColor = UIColor.redColor()
                
            }
            
//            if (messageImageView.center.x <= 219) {
//                println("omg4")
//               
//                msgView.backgroundColor = UIColor.grayColor()
//                archiveIcon.alpha = 0
//            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended{
            println("pan ended")
            msgView.backgroundColor = UIColor.grayColor()
            
            UIView.animateWithDuration(0.2, animations: {() -> Void in
 // Green Show
                
                if velocity.x > 0 && self.messageImageView.center.x >= 220 && self.messageImageView.center.x <= 319
                    { UIView.animateWithDuration(0.2, animations: { () -> Void in
                            println("center ended is between 220 and 319")
                            self.messageImageView.center.x = 640
                            self.msgView.backgroundColor = UIColor.greenColor()
                            self.msgView.alpha = 0
                            self.feedImage.frame.origin.y = 144
                            self.scrollView.contentSize = CGSizeMake(320,1994)
                            
                            }, completion: { (Bool) -> Void in
                               
                        })
 // Red Show
                } else if velocity.x > 0 && self.messageImageView.center.x >= 320
                    
                    { UIView.animateWithDuration(0.2, animations: { () -> Void in
                    println("center ended is past 320")
                    self.messageImageView.center.x = 640
                    self.msgView.backgroundColor = UIColor.redColor()
                    
                }, completion: { (Bool) -> Void in
                    self.msgView.alpha = 0
                    self.feedImage.frame.origin.y = 144
                    self.scrollView.contentSize = CGSizeMake(320,1994)
                })
// Yellow show
                } else if velocity.x < 0 && self.messageImageView.center.x <= 100 && self.messageImageView.center.x >= 1
                { UIView.animateWithDuration(0.2, animations: { () -> Void in
                println("center ended is less than 101 greater than 1")
                self.msgView.backgroundColor = UIColor.yellowColor()
                self.messageImageView.center.x = -160
                    
                }, completion: { (finished:Bool) -> Void in
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.rescheduleImage.alpha = 1
                        self.msgView.alpha = 0
                        self.feedImage.frame.origin.y = 144
                        self.scrollView.contentSize = CGSizeMake(320,1994)
                    })
                   
                })
                    // Brown Show

                } else if velocity.x < 0 && self.messageImageView.center.x <= 101     { UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.msgView.backgroundColor = UIColor.brownColor()
                self.messageImageView.center.x = -160
                self.msgView.alpha = 0
                self.listImage.alpha = 1
                
                self.feedImage.frame.origin.y = 144
                self.scrollView.contentSize = CGSizeMake(320,1994)
                }, completion: { (Bool) -> Void in
                
                })
                
                } else {
                    self.msgView.backgroundColor = UIColor.grayColor()
                    self.messageImageView.center.x = 160
                        
                }
                
                })
    }
}
    
    @IBAction func onListTap(sender: AnyObject) {
        println("dismissing list image")
        listImage.alpha = 0
        self.msgView.alpha = 1
        self.feedImage.alpha = 1
        self.messageImageView.center.x = 160


    }
    
    @IBAction func onRescheduleTap(sender: AnyObject) {
        rescheduleImage.alpha = 0
        self.msgView.alpha = 1
        self.feedImage.alpha = 1
        self.messageImageView.center.x = 160
        
    }
    
   
        
 
}
