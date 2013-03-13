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
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView2;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSArray *imgViews;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic) int imageOffset;

@end


@implementation HomeViewController

@synthesize scrollView = _scrollView,
            scrollView2 = _scrollView2,
            pageControl = _pageControl,
            imgViews = _imgViews,
            imageOffset = _imageOffset,
            timer = _timer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Call the method setupSlideShow.
    [self setupSlideShow];
}


// Setup the home tab's slideshow.
- (void)setupSlideShow
{
    UIImage *img1 = [UIImage imageNamed:@"ssimage01.png"];
    UIImage *img2 = [UIImage imageNamed:@"ssimage02.png"];
    UIImage *img3 = [UIImage imageNamed:@"ssimage03.png"];
    UIImage *img4 = [UIImage imageNamed:@"ssimage04.png"];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:img1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:img2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:img3];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:img4];
    
    
    _imgViews = [NSArray arrayWithObjects:imageView1, imageView2, imageView3, imageView4, nil];
    
    self.scrollView2 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView2.pagingEnabled = YES;
    self.scrollView2.bounces = NO;
    self.scrollView2.showsHorizontalScrollIndicator = NO;
    self.scrollView2.showsVerticalScrollIndicator = NO;
    self.scrollView2.scrollsToTop = NO;
    self.scrollView2.delegate = self;
    
    
    [self.scrollView addSubview: self.scrollView2];
    
    CGRect cRect = imageView1.bounds;
    UIImageView *cView;
    for (int i = 0; i < _imgViews.count; i++)
    {
        cView = [_imgViews objectAtIndex:i];
        cView.frame = cRect;
        [self.scrollView2 addSubview:cView];
        cRect.origin.x += cRect.size.width;
    }
    self.scrollView2.contentSize = CGSizeMake(cRect.origin.x, self.scrollView2.bounds.size.height);
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                              target:self
                                            selector:@selector(onTimer)
                                            userInfo:nil
                                             repeats:YES];
}

// When the timer is done this method gets called.
- (void) onTimer
{
    // Updates the variable _imageWidth.
    if (_imageOffset >= 320*3) {
        _imageOffset = 0;
    }
    else
        _imageOffset += 320;
    NSLog(@"onTimer: %d", _imageOffset);
    // This makes the scrollView scroll to the next image.
    [self.scrollView2 setContentOffset:CGPointMake(_imageOffset, 0) animated:YES];
}

// Reset the timer.
-(void)resetTimer:(id)sender
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
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
    _imageOffset = page*320;
    [self resetTimer:self.timer];
}

@end
