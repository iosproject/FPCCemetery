//
//  TombDataManager.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/12/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TombDataManager : NSObject
{
    NSMutableArray* tombs;
}

@property (readonly)NSArray* tombs;

+(TombDataManager *)instance;
-(NSMutableArray *)filterTombsWithLastName:(NSString *)lastName;


@end
