//
//  CemeteryAppViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSArray *imgViews;
@property (nonatomic, retain) NSTimer *timer;

@end


@implementation HomeViewController

@synthesize scrollView = _scrollView,
pageControl = _pageControl,
imgViews = _imgViews,
timer = _timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSlideShow];
}


// Setup the home tab's slideshow.
- (void)setupSlideShow
{
    UIImage *img1 = [UIImage imageNamed:@"ssimage01.png"];
    UIImage *img2 = [UIImage imageNamed:@"ssimage02.png"];
    UIImage *img3 = [UIImage imageNamed:@"ssimage03.png"];
    UIImage *img4 = [UIImage imageNamed:@"ssimage04.png"];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:img4];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:img1];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:img2];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:img3];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:img4];
    UIImageView *imageView6 = [[UIImageView alloc] initWithImage:img1];
    
    
    _imgViews = [NSArray arrayWithObjects: imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, nil];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    CGRect cRect = imageView1.bounds;
    UIImageView *cView;
    
    for (int i = 0; i < _imgViews.count; i++)
    {
        cView = [_imgViews objectAtIndex:i];
        cView.frame = cRect;
        [self.scrollView addSubview:cView];
        cRect.origin.x += cRect.size.width;
    }
    
    self.scrollView.contentSize = CGSizeMake(cRect.origin.x, cRect.size.height);
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    [self startSlideShow];
    
}

- (void) startSlideShow
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                              target:self
                                            selector:@selector(onTimer)
                                            userInfo:nil
                                             repeats:YES];
}

- (void) stopSlideShow
{
    [_timer invalidate];
}

// When the timer is done this method gets called.
- (void) onTimer
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
}

// Reset the timer.
-(void)resetTimer
{
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                              target:self
                                            selector:@selector(onTimer)
                                            userInfo:nil
                                             repeats:YES];
}

// Things to do when the scroll view has scrolled.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x == 0)
    {
        [self.scrollView setContentOffset:CGPointMake(1280, 0) animated:NO];
    }
    else if (self.scrollView.contentOffset.x == 1600)
    {
        [self.scrollView setContentOffset:CGPointMake(320, 0) animated:NO];
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth);
    _pageControl.currentPage = page;
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetTimer];
}

@end
