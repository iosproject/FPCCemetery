//
//  ImageGalleryViewController.m
//  CemeteryApp
//
//  Created by Carlos Silva on 10/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "ImageDetailViewController.h"
#import "Cell.h"

NSString *kDetailedViewControllerID = @"ImageDetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

@interface ImageGalleryViewController ()

@end

@implementation ImageGalleryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _allImages = [@[@"0_full.jpg",
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
                  @"15_full.jpg",
                  @"16_full.jpg",
                  @"17_full.jpg",
                  @"18_full.jpg",
                  @"19_full.jpg",
                  @"20_full.jpg",
                  @"21_full.jpg",
                  @"22_full.jpg",
                  @"23_full.jpg",
                  @"24_full.jpg",
                  @"25_full.jpg",
                  @"26_full.jpg",
                  @"27_full.jpg",
                  @"28_full.jpg",
                  @"29_full.jpg",
                  @"30_full.jpg",
                  @"31_full.jpg"] mutableCopy];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return _allImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    // load the image for this cell
    cell.image.image = [UIImage imageNamed:_allImages[indexPath.row]];
    
    return cell;
}

// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showImageDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
        /*NSString *imageNameToLoad = [NSString stringWithFormat:@"%d_full", selectedIndexPath.row];
         NSString *pathToImage = [[NSBundle mainBundle] pathForResource:imageNameToLoad ofType:@"JPG"];
         UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImage];*/ // needs further investigation
        
        UIImage *image2 = [UIImage imageNamed:_allImages[selectedIndexPath.row]];
        
        ImageDetailViewController *imageDetailViewController = [segue destinationViewController];
        imageDetailViewController.image = image2;
    }
}

@end
