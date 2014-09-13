//
//  CategoricalNearbyEventTableViewCell.m
//  OurMaps
//
//  Created by Wei Lu on 9/11/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "CategoricalNearbyEventTableViewCell.h"

@implementation CategoricalNearbyEventTableViewCell

@synthesize type;
@synthesize eventCount;
@synthesize eventLabel = _eventLabel;
@synthesize iconImgView = _iconImgView;
@synthesize categoryLabel = _categoryLabel;

- (void)awakeFromNib {
    // Initialization code
    _eventLabel.text = @"0 Events";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(NSString *)aType {
    type = aType;
    if (type) {
        _categoryLabel.text = type;
        //_eventLabel.text = @"0 Events";
    }
}

- (void)setEventCount:(NSInteger)aCount {
    eventCount = aCount;
    if (eventCount) {
        _eventLabel.text = [NSString stringWithFormat:@"%lu Events", eventCount];
    }
}

@end
