//
//  DetailsViewController.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
{
    NSDictionary *selectedTomb;
    NSInteger selectedIndex;
}

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, retain) NSDictionary *selectedTomb;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
