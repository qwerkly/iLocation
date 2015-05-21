//
//  IBUIView.m
//  iLocation
//
//  Created by Ivan Babich on 21.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import "IBUIView.h"

@implementation IBUIView

// В этом методе мы устанавливаем вид надписи над меткой
-(UIView *) getCalloutView: (NSString *) title {
    UIView * callView = [[UIView alloc]initWithFrame:CGRectMake(-100, -100, 250, 100)];
    callView.backgroundColor = [UIColor blackColor];
    callView.layer.cornerRadius = 15;           // Радиус закругления
    callView.tag = 1000;
    callView.alpha = 0;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 240, 90)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;  // Выравнивание текста по левому краю
    label.textColor = [UIColor whiteColor];
    label.text = title;
    
    [callView addSubview:label];        // Добавляем слова на табличку
    return callView;
}

@end
