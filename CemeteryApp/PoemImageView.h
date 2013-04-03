//
//  PoemImageView.h
//  CemeteryApp
//
//  Created by Computer Science on 3/20/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoemImageView : UIImageView
@property (strong, atomic) NSArray *poemFileNames;
- (void) setUpPoemView;
@end
