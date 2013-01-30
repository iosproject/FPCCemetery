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

@property (nonatomic, strong) NSMutableArray *images;

@end


@implementation HomeViewController

@synthesize imageView = _imageView;
@synthesize textView = _textView;
@synthesize images = _images;
@synthesize databaseCheckAlertView;
@synthesize loading;

// just a comment
- (void)viewDidLoad
{
    [super viewDidLoad];
    databaseCheckAlertView = [[UIAlertView alloc] initWithTitle:@"Please Wait" message:@"Checking server for updates..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //loading.frame = CGRectMake(150, 150, 16, 16);
    loading.center = CGPointMake(139.5, 90.5);
    [databaseCheckAlertView addSubview:loading];
    [loading startAnimating];
    [databaseCheckAlertView show];
    [self updateLocalJSONFile];
	// Do any additional setup after loading the view, typically from a nib.
     //JSONHandler *db = [[JSONHandler alloc] init];
    [self setupSlideshow];
}

- (void)setupSlideshow
{
    _imageView.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"ssimage00.png"],
                                  [UIImage imageNamed:@"ssimage01.png"],
                                  [UIImage imageNamed:@"ssimage02.png"],
                                  [UIImage imageNamed:@"ssimage03.png"],
                                  [UIImage imageNamed:@"ssimage04.png"],nil];
    _imageView.animationDuration = 25.00; // seconds
    _imageView.animationRepeatCount = 0; //infinite
    [_imageView startAnimating]; //start the animation
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [_imageView startAnimating]; //start the animation4
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_imageView stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLocalJSONFile
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [pathArray objectAtIndex:0];
    NSString *localFile = [documentsDir stringByAppendingPathComponent:@"result.json"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[documentsDir stringByAppendingPathComponent:@"result.json"]])
    {
        NSURL *url = [NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:localFile atomically:YES];
    }
    else
    {
        //We have a local version of the DB but is it the latest?
        //Check for the updated version
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"]];
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
            NSURL *url = [NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [data writeToFile:localFile atomically:YES];
            [databaseCheckAlertView setMessage:@"Database updated"];
        }
    }
    [loading stopAnimating];
    [databaseCheckAlertView dismissWithClickedButtonIndex:-1 animated:YES];
}
@end
