//
//  BurialMapViewController.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 3/12/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BurialMapViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *mapScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
