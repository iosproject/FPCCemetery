//
//  CemeteryAppViewController.h
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIGestureRecognizerDelegate> 

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *recognizer;


- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

@end
