//
//  MapViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

- (void)loadView {
	UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	scroll.backgroundColor = [UIColor blackColor];
	scroll.delegate = self;
	image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Map.png"]];
	scroll.contentSize = image.frame.size;
	[scroll addSubview:image];
	
	scroll.minimumZoomScale = scroll.frame.size.width / image.frame.size.width;
	scroll.maximumZoomScale = 2.0;
	[scroll setZoomScale:scroll.minimumZoomScale];
    
	self.view = scroll;
	//[scroll release];
    
}
//stupid xcode
- (void)viewDidUnload {
	//[image release], image = nil;
}


- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView {
	CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
	
	return frameToCenter;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    image.frame = [self centeredFrameForScrollView:scrollView andUIView:image];;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return image;
}

@end
