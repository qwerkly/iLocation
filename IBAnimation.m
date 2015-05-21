//
//  Animation.m
//  iLocation
//
//  Created by Ivan Babich on 19.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import "IBAnimation.h"

@implementation IBAnimation

+(void) change_TextField:(UIView *) label Alpha:(CGFloat) alpha {
    
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.35;
    [label.layer addAnimation:animation forKey:@"Fade"];
    label.alpha = alpha;
    
}

+(void) change_View:(UIView *) label Alpha:(int) alpha {
    
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration = 0.35;
    [label.layer addAnimation:animation forKey:@"Fade"];
    label.alpha = alpha;
    
}

@end
