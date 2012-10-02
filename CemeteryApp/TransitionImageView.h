//
//  TransitionImageView.h
//  CemeteryApp
//
//  Created by student on 10/1/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TransitionImageView : UIImageView
{
    UIImageView *mOriginalImageViewContainerView;
    UIImageView *mIntermediateTransitionView;
}
@property (nonatomic, retain) UIImageView *originalImageViewContainerView;
@property (nonatomic, retain) UIImageView *intermediateTransitionView;

#pragma mark -
#pragma mark Animation methods

-(void)setImage:(UIImage *)inNewImage withTransitionAnimation:(BOOL)inAnimation;

@end
