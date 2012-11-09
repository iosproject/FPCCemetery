//
//  SearchFilter.h
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFilter : NSObject

@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UITextField *filterF;

- (IBAction)getJsonData:(id)sender;
+ (BOOL)regEx:(NSString *)search: (NSString *)toBeSearched;
+ (NSMutableArray *)getInfo:(NSString *)personId;
+ (NSMutableArray *)parseJson:(NSMutableArray *)jsonArray: (NSString *)search: (NSString *) filter;
+ (void) connectToJson;
+ (NSMutableArray *)getDBColumns;

@end
