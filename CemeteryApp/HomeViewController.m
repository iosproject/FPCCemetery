//
//  CemeteryAppViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "HomeViewController.h"
#import "JSONHandler.h"

@interface HomeViewController ()
@property (nonatomic) int w;

@property (nonatomic, strong) NSMutableArray *images;

@end


@implementation HomeViewController

@synthesize scrollView = _scrollView, scrollView2 = _scrollView2;
@synthesize pageControl = _pageControl;
@synthesize imgViews = _imgViews;
@synthesize w;
@synthesize timer = _timer;
@synthesize databaseCheckAlertView;
@synthesize loading;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    databaseCheckAlertView = [[UIAlertView alloc] initWithTitle:@"Please Wait"
                                                        message:@"Checking server for updates..."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //loading.frame = CGRectMake(150, 150, 16, 16);
    loading.center = CGPointMake(139.5, 90.5);
    [databaseCheckAlertView addSubview:loading];
    [loading startAnimating];
    [databaseCheckAlertView show];
    [self updateLocalJSONFile];
	// Do any additional setup after loading the view, typically from a nib.
     //JSONHandler *db = [[JSONHandler alloc] init];
 
    [self setupSlideShow];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define FILE_URL @"http://eve.kean.edu/~jplisojo/result2.json"
#define LOCAL_FILE_NAME @"result.json"

- (void)updateLocalJSONFile
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [pathArray objectAtIndex:0];
    NSString *localFile = [documentsDir stringByAppendingPathComponent:LOCAL_FILE_NAME];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[documentsDir stringByAppendingPathComponent:LOCAL_FILE_NAME]])
    {
        NSURL *url = [NSURL URLWithString:FILE_URL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:localFile atomically:YES];
    }
    else
    {
        //We have a local version of the DB but is it the latest?
        //Check for the updated version
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:FILE_URL]];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *error = nil;
        NSArray *serverJson = [[NSArray alloc] init];
        serverJson = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        
        NSData *clientresponse = [NSData dataWithContentsOfFile:localFile];
        NSArray *clientJson = [[NSMutableArray alloc] init];
        clientJson = [NSJSONSerialization JSONObjectWithData:clientresponse options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *serverdict = [[NSDictionary alloc] init];
        NSDictionary *clientdict = [[NSDictionary alloc] init];
        
        clientdict = [clientJson objectAtIndex:0];
        serverdict = [serverJson objectAtIndex:0];
        
        if([[clientdict objectForKey:@"LastUpdated"] intValue] < [[serverdict objectForKey:@"LastUpdated"] intValue])
        {
            [databaseCheckAlertView setMessage:@"Database updates being applied"];
            //Copy from server to local
            NSURL *url = [NSURL URLWithString:FILE_URL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [data writeToFile:localFile atomically:YES];
            [databaseCheckAlertView setMessage:@"Database updated"];
        }
    }
    [loading stopAnimating];
    [databaseCheckAlertView dismissWithClickedButtonIndex:-1 animated:YES];
    
}

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
    
    
    //UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
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
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];

}


- (void) onTimer
{
    // Updates the variable w, adding 320
    if (w >= 320*3) {
        w=0;
    }
    else
        w += 320;
    
    //This makes the scrollView scroll to the desired position
    [self.scrollView2 setContentOffset:CGPointMake(w, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"did end decelerating");
    //scrollView.contentOffset.x = CGPointMake(scrollView.bounds.size.width, 0);
}

-(void)resetTimer:(id)sender {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
    w = page*320;
    [self resetTimer:self.timer];
}




@end
