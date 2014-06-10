//
//  ImageGalleryCollectionViewController.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 3/13/14.
//  Copyright (c) 2014 KeanU. All rights reserved.
//

#import "ImageGalleryCollectionViewController.h"
#import "ImageDetailViewController.h"

@interface ImageGalleryCollectionViewController ()

@end

@implementation ImageGalleryCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"prepare for segue");
    if ([[segue identifier] isEqualToString:@"showImageDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        UIImage *image2 = [UIImage imageNamed:self.tombImages[selectedIndexPath.row]];
        
        ImageDetailViewController *imageDetailViewController = [segue destinationViewController];
        imageDetailViewController.image = image2;
        
        imageDetailViewController.imageArray = _tombImages;
        imageDetailViewController.imageIndex = selectedIndexPath.row;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageGalleryCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"ImageCell"
                                    forIndexPath:indexPath];
    
    UIImage *image;
    long row = [indexPath row];
    
    image = [UIImage imageNamed:_tombImages[row]];
    
    myCell.imageView.image = image;
    
    return myCell;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return _tombImages.count;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tombImages = [@[@"0_full.jpg",
                    @"1_full.jpg",
                    @"2_full.jpg",
                    @"3_full.jpg",
                    @"4_full.jpg",
                    @"5_full.jpg",
                    @"6_full.jpg",
                    @"7_full.jpg",
                    @"8_full.jpg",
                    @"9_full.jpg",
                    @"10_full.jpg",
                    @"11_full.jpg",
                    @"12_full.jpg",
                    @"13_full.jpg",
                    @"14_full.jpg",
                    @"15_full.jpg"] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
