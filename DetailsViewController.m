//
//  DetailsViewController.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize selectedTomb, selectedIndex;
@synthesize scrollView = _scrollView;
@synthesize textView = _textView,
bornTextField = _bornTextField,
diedTextField = _diedTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)designTextView
{
    _textView.layer.cornerRadius = 5;
    _textView.clipsToBounds = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self designTextView];
        
    [self.scrollView setContentSize:CGSizeMake(320, 455)];
    [_bornTextField setText:selectedTomb.birthDate];
    [_diedTextField setText:selectedTomb.deathDate];
    [_sectionTextField setText:selectedTomb.section];
    [_textView setText:selectedTomb.epitaph];
    
    if ([selectedTomb.years isEqualToString:@"0"])
    {
        [_ageTextField setText:[NSString stringWithFormat:@"%@ months", selectedTomb.months]];
    }
    else if ([selectedTomb.birthDate isEqualToString:@"n/a"])
    {
        [_ageTextField setText:@"n/a"];
    }
    else if ([selectedTomb.birthDate isEqualToString:@" "])
    {
        [_ageTextField setText:@"n/a"];
    }
    else
        [_ageTextField setText:[NSString stringWithFormat:@"%@ years", selectedTomb.years]];
    
    [_textView setText: [NSString stringWithFormat:@"%@", selectedTomb.epitaph,nil]];
    [self.scrollView flashScrollIndicators];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set the tiitle of the navigation bar
    if([selectedTomb.middleName isEqual:nil] || [selectedTomb.middleName isEqual:NULL] || [selectedTomb.middleName isEqualToString:@""])
    {
        if([selectedTomb.middleName length] == 1)
        {
            [selectedTomb.middleName stringByAppendingString:@"."];
        }
        [self setTitle:[NSString stringWithFormat:@"%@ %@", selectedTomb.firstName, selectedTomb.lastName]];
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"%@ %@ %@", selectedTomb.firstName, selectedTomb.middleName,selectedTomb.lastName]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
       [super viewDidUnload];
}
@end
