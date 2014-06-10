//
//  ImageGalleryCollectionViewController.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 3/13/14.
//  Copyright (c) 2014 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageGalleryCell.h"

@interface ImageGalleryCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *tombImages;

@end
