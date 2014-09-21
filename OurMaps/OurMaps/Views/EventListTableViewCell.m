//
//  EventListTableViewCell.m
//  OurMaps
//
//  Created by Wei Lu on 9/20/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "EventListTableViewCell.h"

@implementation EventListTableViewCell

@synthesize event;
@synthesize titleLabel = _titleLabel;
@synthesize iconImgView = _iconImgView;
@synthesize peopleLabel = _peopleLabel;
@synthesize peopleCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEvent:(Event *)anEvent
{
    event = anEvent;
    if (event) {
        _titleLabel.text = event.title;
    }
}

- (void)setPeopleCount:(NSInteger)aCount
{
    peopleCount = aCount;
    if (peopleCount) {
        _peopleLabel.text = [NSString stringWithFormat:@"%lu People", peopleCount];
    }
}

@end
