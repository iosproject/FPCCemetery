//
//  TombstoneViewController.m
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "TombstoneViewController.h"

@interface TombstoneViewController ()

@end

@implementation TombstoneViewController
@synthesize tombstoneImageView = _tombstoneImageView,
            tombstoneNumber = _tombstoneNumber,
            tombstoneScrollView = _tombstoneScrollView,
            activityView = _activityView,
            loadingView = _loadingView,
            loadingLabel = _loadingLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    _tombstoneScrollView.delegate = self;
    [self fetchTombstoneImage];
	_tombstoneScrollView.contentSize = _tombstoneImageView.frame.size;
	_tombstoneScrollView.minimumZoomScale = _tombstoneScrollView.frame.size.width / _tombstoneImageView.frame.size.width;
	_tombstoneScrollView.maximumZoomScale = 2.0;
	[_tombstoneScrollView setZoomScale:_tombstoneScrollView.minimumZoomScale];
    [self setupDoubleTapGesture];
}

- (void) setupDoubleTapGesture
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    
    [_tombstoneScrollView addGestureRecognizer:doubleTap];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if(_tombstoneScrollView.zoomScale > _tombstoneScrollView.minimumZoomScale)
        [_tombstoneScrollView setZoomScale:_tombstoneScrollView.minimumZoomScale animated:YES];
    else
        [_tombstoneScrollView setZoomScale:_tombstoneScrollView.maximumZoomScale animated:YES];
}



- (void)fetchTombstoneImage
{
    NSString *stringURL = [NSString stringWithFormat: @"http://localhost/databasepics/0-99/%@.jpg", _tombstoneNumber];
    
    NSLog(@"%@", stringURL);
    
    NSURL *url = [NSURL URLWithString:stringURL];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    [_tombstoneImageView setImage:image];
}

- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView
{
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

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _tombstoneImageView.frame = [self centeredFrameForScrollView:scrollView andUIView:_tombstoneImageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _tombstoneImageView;
}

@end
