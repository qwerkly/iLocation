//
//  IBCells.h
//  iLocation
//
//  Created by Ivan Babich on 21.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBCells : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_City;
@property (weak, nonatomic) IBOutlet UILabel *label_Index;
@property (weak, nonatomic) IBOutlet UILabel *label_Street;

@end
