//
//  IBMakeArrays.m
//  iLocation
//
//  Created by Ivan Babich on 21.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import "IBMakeArrays.h"

@implementation IBMakeArrays

+ (NSMutableArray *) makeArray: (NSString *) addCity Street: (NSString *) addStreet Index: (NSString *) addIndex {
    
    NSMutableArray * arrayM = [NSMutableArray new];
    
    NSString * stringCity = [NSString stringWithFormat:@"Город - %@",addCity];
    NSString * stringStreet = [NSString stringWithFormat:@"Улица - %@",addStreet];
    NSString * stringIndex = [NSString stringWithFormat:@"Индекс - %@",addIndex];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:stringCity,@"Город",stringStreet,@"Улица",stringIndex,@"Индекс", nil];
    
    [arrayM addObject:dict];

    return arrayM;
}

@end
