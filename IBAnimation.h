//
//  Animation.h
//  iLocation
//
//  Created by Ivan Babich on 19.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface IBAnimation : NSObject

+(void) change_TextField:(UIView *) label Alpha:(CGFloat) alpha;
+(void) change_View:(UIView *) label Alpha:(int) alpha;

@end
