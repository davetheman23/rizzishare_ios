//
//  EventListTableViewCell.h
//  OurMaps
//
//  Created by Wei Lu on 9/20/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@property (strong, nonatomic) Event *event;

@property (nonatomic) NSInteger peopleCount;

@end
