//
//  FKSliderField.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "FKSliderField.h"

#import "FKMacrosDefinitions.h"

#define SLIDER_MARGIN 20


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation FKSliderField

@synthesize slider = _slider;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _slider = [[UISlider alloc] init];
        self.valueView = self.slider;
    }
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.slider.frame = CGRectMake(self.textLabel.frame.origin.x + CGRectGetWidth(self.textLabel.frame) + SLIDER_MARGIN,
                                   self.textLabel.frame.origin.y,
                                   CGRectGetWidth(self.contentView.frame) - CGRectGetWidth(self.textLabel.frame) - CGRectGetWidth(self.textLabel.frame) - SLIDER_MARGIN * 2,
                                   CGRectGetHeight(self.valueView.frame));
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.slider removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    self.slider.value = 0;
}


@end
