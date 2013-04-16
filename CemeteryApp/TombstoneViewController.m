//
//  TombstoneViewController.m
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "TombstoneViewController.h"
#import "QuartzCore/QuartzCore.h"

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
    [self showLoadingView];
    [self configureScrollview];
    [self fetchTombstoneImage];
    [self setupDoubleTapGesture];
    [self hideLoadingView];
}

-(void) configureScrollview
{
    _tombstoneScrollView.delegate = self;
    _tombstoneScrollView.contentSize = _tombstoneImageView.frame.size;
	_tombstoneScrollView.minimumZoomScale = _tombstoneScrollView.frame.size.width / _tombstoneImageView.frame.size.width;
	_tombstoneScrollView.maximumZoomScale = 2.0;
	[_tombstoneScrollView setZoomScale:_tombstoneScrollView.minimumZoomScale];
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
    //NSLog(@"%@", stringURL);
    NSURL *url = [NSURL URLWithString:stringURL];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    if (!image)
    {
        image = [UIImage imageNamed:@"not_available.png"];
    }
    
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

- (void) hideLoadingView
{
    [_activityView stopAnimating];
    [_loadingView removeFromSuperview];
}

- (void) showLoadingView
{
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.25 alpha:0.25];
    _loadingView.layer.borderColor = [[UIColor blueColor] CGColor];
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 10.0;
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(65, 40, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [_loadingView addSubview:_activityView];
    
    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    _loadingLabel.backgroundColor = [UIColor clearColor];
    _loadingLabel.textColor = [UIColor whiteColor];
    _loadingLabel.adjustsFontSizeToFitWidth = YES;
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.text = @"Loading...";
    [_loadingView addSubview:_loadingLabel];
    
    [self.view addSubview:_loadingView];
    [_activityView startAnimating];
}


@end
