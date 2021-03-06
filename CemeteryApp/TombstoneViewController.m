//
//  TombstoneViewController.m
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "TombstoneViewController.h"
#import "QuartzCore/QuartzCore.h"
#include <sys/xattr.h>

@interface TombstoneViewController ()
{
    UIImage *image;
    NSURL *url;
}

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchTombstoneImage]; // 1
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tombstoneImageView setImage:image]; // 2
            [self hideLoadingView]; // 3
        });
    });
    
    [self configureScrollview];
    [self setupDoubleTapGesture];
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
    NSInteger tombInt = [_tombstoneNumber integerValue];
    NSString *stringURL = nil;
    
    if (tombInt > 0 && tombInt < 100)
    {
        stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/tombstone_images/0-99/%@.jpg", _tombstoneNumber];
    }
    else if (tombInt > 99 && tombInt < 200)
    {
        stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/tombstone_images/100s/%@.jpg", _tombstoneNumber];
    }
    else if (tombInt > 199 && tombInt < 300)
    {
        stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/tombstone_images/200s/%@.jpg", _tombstoneNumber];
    }
    else if (tombInt > 299 && tombInt < 400)
    {
        stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/tombstone_images/300s/%@.jpg", _tombstoneNumber];
    }
    else if (tombInt > 399 && tombInt < 511)
    {
        stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/tombstone_images/400s_500s/%@.jpg", _tombstoneNumber];
    }
    else if (tombInt > 510 && tombInt < 1809)
    {
        stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/tombstone_images/500-977and Alpa rows/%@.jpg", _tombstoneNumber];
    }
    
    //NSLog(@"%@", stringURL);
    url = [NSURL URLWithString:stringURL];
    image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    if (!image)
    {
        image = [UIImage imageNamed:@"not_available.png"];
    }
}
/*
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    if (&NSURLIsExcludedFromBackupKey == nil) {
        // iOS 5.0.1 and lower
        u_int8_t attrValue = 1;
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    } else {
        // First try and remove the extended attribute if it is present
        int result = getxattr(filePath, attrName, NULL, sizeof(u_int8_t), 0, 0);
        if (result != -1) {
            // The attribute exists, we need to remove it
            int removeResult = removexattr(filePath, attrName, 0);
            if (removeResult == 0) {
                NSLog(@"Removed extended attribute on file %@", URL);
            }
        }
        
        // Set the new key
        return [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
    }
}
*/
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
