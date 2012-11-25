//
//  DetailsViewController.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize selectedIndex, selectedTomb;
@synthesize textView = _textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_textView setText: [NSString stringWithFormat:@"\nID: %@\nSection: %@\nDate of Birth: %@\nDate of Death: %@\nPrefix: %@\nSuffix: %@\nYears: %@\nMonths: %@\nNotes: %@\nSexton's Notes: %@\n\nEpitaph: %@\nReference: %@\nTour: %@\nInternet Link: %@\nSandstone: %@\nCondition: %@\nVeteran  \n\n%@", selectedTomb.tombId, selectedTomb.section, selectedTomb.birthDate, selectedTomb.deathDate, selectedTomb.prefix, selectedTomb.suffix, selectedTomb.years, selectedTomb.months, selectedTomb.notes, selectedTomb.sextonsNotes, selectedTomb.epitaph, selectedTomb.ref, selectedTomb.tour, selectedTomb.internet, selectedTomb.sandstone, selectedTomb.condition, selectedTomb.veteran ,nil]];
}

- (void)viewWillAppear:(BOOL)animated
{
    if([selectedTomb.middleName isEqual:nil] || [selectedTomb.middleName isEqual:NULL] || [selectedTomb.middleName isEqualToString:@""])
    {
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
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
