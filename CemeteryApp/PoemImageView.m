//
//  PoemImageView.m
//  CemeteryApp
//
//  Created by Computer Science on 3/20/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "PoemImageView.h"

@implementation PoemImageView
@synthesize poemFileNames = _poemFileNames;

// randomly choose an image
- (void) setUpPoemView{
    _poemFileNames = [[NSArray alloc] initWithObjects:@"poem_1.png",
                                                      @"poem_2.png",
                                                      @"poem_3.png",
                                                      @"poem_4.png",
                                                      @"poem_5.png",
                                                      @"poem_6.png",
                                                      @"poem_7.png",
                                                      @"poem_8.png",
                                                      @"poem_9.png",
                                                      @"poem_10.png", nil];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        NSInteger randomIndex = arc4random() % _poemFileNames.count;
        
        NSString *fileName = _poemFileNames[randomIndex];
        UIImage *image;
        
        // This if statement recognizes which version of iPhone the user has.
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
            fileName = [NSString stringWithFormat:@"i5_%@",fileName];
            image = [UIImage imageNamed:fileName];
            self.image = image;
        } else {
            /*Do iPhone Classic stuff here.*/
            image = [UIImage imageNamed:fileName];
            self.image = image;
        }
    } else {
        /*Do iPad stuff here.*/
    }
}

@end
