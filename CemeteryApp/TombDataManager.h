//
//  TombDataManager.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/12/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tomb.h"

@interface TombDataManager : NSObject
{
    NSMutableArray* tombs;
   //NSArray *jsonArray;
    Tomb *tomb;
}

//@property (readonly)NSArray* tombs;
@property(readonly)NSMutableArray *tombs;
//@property(readonly)NSArray *jsonArray;
@property (readwrite) bool didGetCols;

+(TombDataManager *)instance;

-(NSMutableArray *)filterTombs:(NSString *)search:(NSString *)filter;


@end
