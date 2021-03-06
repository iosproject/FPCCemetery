//
//  TombDetailViewController.m
//  BurialSearch
//
//  Created by Joshua Lisojo on 3/6/13.
//  Copyright (c) 2013 Lisojo. All rights reserved.
//

#import "TombDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SectionViewController.h"
#import "TombstoneViewController.h"

@interface TombDetailViewController ()

@end

@implementation TombDetailViewController

@synthesize selectedTomb = _selectedTomb;
@synthesize scrollView = _scrollView;
@synthesize epitaphTextView = _epitaphTextView,
            bornTextField = _bornTextField,
            diedTextField = _diedTextField,
            veteranTextField = _veteranTextField,
            causeOfDeathTextField = _causeOfDeathTextField,
            viewTombstoneButton = _viewTombstoneButton,
            viewSectionButton = _viewSectionButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [_bornTextField setText:_selectedTomb.birthDate];
    [_diedTextField setText:_selectedTomb.deathDate];
    [_sectionTextField setText:_selectedTomb.section];
    [_causeOfDeathTextField setText: _selectedTomb.causeOfDeath];
    [self setAgeString];
    [self setVeteranString];
    [self setEpitaphString];
    [self styleEpitaphTextView];
    [self styleTombstoneButton];
    [self styleSectionButton];
}

- (void) setEpitaphString
{
    if ([_selectedTomb.epitaph isEqualToString:@""])
    {
        [_epitaphTextView setText:@"No Epitaph Available"];
    }
    else
        [_epitaphTextView setText: [NSString stringWithFormat:@"%@", _selectedTomb.epitaph, nil]];
}

- (void) setAgeString
{
    if ([_selectedTomb.years isEqualToString:@"0"])
    {
        [_ageTextField setText:[NSString stringWithFormat:@"%@ months", _selectedTomb.months]];
    }
    else if ([_selectedTomb.birthDate isEqualToString:@"n/a"])
    {
        [_ageTextField setText:@"n/a"];
    }
    else if ([_selectedTomb.birthDate isEqualToString:@" "])
    {
        [_ageTextField setText:@"n/a"];
    }
    else
        [_ageTextField setText:[NSString stringWithFormat:@"%@ years", _selectedTomb.years]];
}

- (void) setVeteranString
{
    if([_selectedTomb.veteran isEqualToString:@"0"])
    {
        [_veteranTextField setText:@"No"];
    }
    else
        [_veteranTextField setText:@"Yes"];
}

- (void) styleEpitaphTextView
{
    
    [_epitaphTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [_epitaphTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [_epitaphTextView.layer setBorderWidth: 1.0];
    [_epitaphTextView.layer setCornerRadius:8.0f];
    [_epitaphTextView.layer setMasksToBounds:YES];
    
    [_epitaphTextView setEditable:NO];
    [_epitaphTextView setScrollEnabled:YES];
    [_epitaphTextView setText:_selectedTomb.epitaph];
    [_epitaphTextView sizeToFit];
    [_epitaphTextView setScrollEnabled:NO];
    

    CGSize textViewSize = [_epitaphTextView sizeThatFits:CGSizeMake(_epitaphTextView.frame.size.width, FLT_MAX)];
    //_epitaphTextView.height = textViewSize.height;
    //NSLog(@"Heigh of Text View: %f", textViewSize.height);
    [_epitaphTextView setFrame:CGRectMake((self.view.frame.size.width - 280)/2,260,280,textViewSize.height)];
    [self setScrollViewHeight:textViewSize.height];//_epitaphTextView.contentSize.height];
    
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

-(void) styleTombstoneButton
{
    self.viewTombstoneButton.layer.borderColor = [[UIColor blackColor] CGColor];;
    self.viewTombstoneButton.layer.borderWidth = 1.0f;
    self.viewTombstoneButton.layer.cornerRadius = 10;
}

-(void) styleSectionButton
{
    self.viewSectionButton.layer.borderColor = [[UIColor blackColor] CGColor];;
    self.viewSectionButton.layer.borderWidth = 1.0f;
    self.viewSectionButton.layer.cornerRadius = 10;
}

-(void) setScrollViewHeight:(int)height
{
    // height adjust
    height -= 130;
    
    // place buttons under the epitaph 
    _viewTombstoneButton.frame = CGRectMake(20.0, (540+height)-100, 280.0, 40.0);
    _viewSectionButton.frame = CGRectMake(20.0, (540+height)-40, 280.0, 40.0);
    
    // set size of scroll view
    [self.scrollView setContentSize:CGSizeMake(320, 540+height)];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set the tiitle of the navigation bar
    if([_selectedTomb.middleName isEqual:nil] || [_selectedTomb.middleName isEqual:NULL] || [_selectedTomb.middleName isEqualToString:@""])
    {
        if([_selectedTomb.middleName length] == 1)
        {
            [_selectedTomb.middleName stringByAppendingString:@"."];
        }
        [self setTitle:[NSString stringWithFormat:@"%@ %@", _selectedTomb.firstName, _selectedTomb.lastName]];
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"%@ %@ %@", _selectedTomb.firstName, _selectedTomb.middleName,_selectedTomb.lastName]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSection"])
    {
        SectionViewController *sectionViewController = [segue destinationViewController];
        [sectionViewController setSection:[_selectedTomb.section lowercaseString]];
    }
    else if ([[segue identifier] isEqualToString:@"showTombstone"])
    {
        TombstoneViewController *tombstoneViewController = [segue destinationViewController];
        
        // extract the tomb number from the unique id
        NSMutableString *tombNumber = [[NSMutableString alloc] init];
        for (int i=0; i<[_selectedTomb.uniqueId length]; i++)
        {
            if (isdigit([_selectedTomb.uniqueId characterAtIndex:i]))
            {
                [tombNumber appendFormat:@"%c",[_selectedTomb.uniqueId characterAtIndex:i]];
            }
        }

        // set the tomb number in the destination view controller
        [tombstoneViewController setTombstoneNumber:tombNumber];
    }
}

@end
