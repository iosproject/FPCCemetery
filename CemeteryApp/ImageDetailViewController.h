//
//  ImageDetailViewController.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 2/22/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDetailViewController : UIViewController

@property (nonatomic, strong) UIImage *image;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (nonatomic) NSInteger imageIndex;
@end
