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
    _allImages = [@[@"0_full.png",
                  @"1_full.png",
                  @"2_full.png",
                  @"3_full.png"/*,
                  @"4_full.png",
                  @"5_full.png",
                  @"6_full.png",
                  @"7_full.png",
                  @"8_full.png",
                  @"9_full.png",
                  @"10_full.png",
                  @"11_full.png",
                  @"12_full.png",
                  @"13_full.png",
                  @"14_full.png",
                  @"15_full.png",
                  @"16_full.png"*/] mutableCopy];
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
    //NSLog(@"prepare for segue");
    if ([[segue identifier] isEqualToString:@"showImageDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
        /*NSString *imageNameToLoad = [NSString stringWithFormat:@"%d_full", selectedIndexPath.row];
         NSString *pathToImage = [[NSBundle mainBundle] pathForResource:imageNameToLoad ofType:@"J
         G"];
         UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImage];*/ // needs further investigation
        
        UIImage *image2 = [UIImage imageNamed:self.allImages[selectedIndexPath.row]];
        
        ImageDetailViewController *imageDetailViewController = [segue destinationViewController];
        imageDetailViewController.image = image2;
    }
}

@end
