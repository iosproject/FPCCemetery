//
//  SectionViewController.m
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "SectionViewController.h"
#import "QuartzCore/QuartzCore.h"
#include <sys/xattr.h>

@interface SectionViewController ()
{
    UIImage *image;
    NSURL *url;
}

@end

@implementation SectionViewController

@synthesize sectionImageView = _sectionImageView,
            section = _section,
            sectionScrollView = _sectionScrollView,
            activityView = _activityView,
            loadingView = _loadingView,
            loadingLabel = _loadingLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self showLoadingView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchSectionImage]; // 1
        dispatch_async(dispatch_get_main_queue(), ^{
            [_sectionImageView setImage:image]; // 2
            [self hideLoadingView]; // 3
        });
    });
    
    [self configureScrollview];
    [self setupDoubleTapGesture];
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
-(void) configureScrollview
{
    _sectionScrollView.delegate = self;
    _sectionScrollView.contentSize = _sectionScrollView.frame.size;
    _sectionScrollView.minimumZoomScale = _sectionScrollView.frame.size.width / _sectionScrollView.frame.size.width;
    _sectionScrollView.maximumZoomScale = 2.0;
    [_sectionScrollView setZoomScale:_sectionScrollView.minimumZoomScale];
}

- (void) setupDoubleTapGesture
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    
    [_sectionScrollView addGestureRecognizer:doubleTap];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if(_sectionScrollView.zoomScale > _sectionScrollView.minimumZoomScale)
        [_sectionScrollView setZoomScale:_sectionScrollView.minimumZoomScale animated:YES];
    else
        [_sectionScrollView setZoomScale:_sectionScrollView.maximumZoomScale animated:YES];
}

- (void)fetchSectionImage
{
    NSString *stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/section_images/section_%@.jpeg", [_section substringToIndex:1], nil];
    
    //NSLog(@"%@", stringURL);
    //NSLog(@"fetching image...");

    url = [NSURL URLWithString:stringURL];
    image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    if (!image)
    {
        image = [UIImage imageNamed:@"not_available.png"];
    }
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
    _sectionImageView.frame = [self centeredFrameForScrollView:scrollView andUIView:_sectionImageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _sectionImageView;
}

@end
