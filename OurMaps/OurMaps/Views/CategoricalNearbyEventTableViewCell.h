//
//  CategoricalNearbyEventTableViewCell.h
//  OurMaps
//
//  Created by Wei Lu on 9/11/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoricalNearbyEventTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;

@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;

@property (nonatomic, strong) NSString *type;

@property (nonatomic) NSInteger *eventCount;

@end
