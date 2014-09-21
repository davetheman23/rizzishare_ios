//
//  FKTitleHeaderView.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import "FKTitleHeaderView.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation FKTitleHeaderView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.numberOfLines = 0;
        self.textLabel.textColor = [UIColor grayColor];
        self.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1];
        
        [self addSubview:self.textLabel];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectZero;
    frame.origin.x = 10;
    frame.origin.y = 14;
    frame.size.width = self.frame.size.width - frame.origin.x*2;
    frame.size.height = [self.textLabel sizeThatFits:CGSizeMake(frame.size.width, CGFLOAT_MAX)].height;
    
    self.textLabel.frame = frame;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark FKTitleHeaderViewProtocol

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeaderTitle:(NSString *)title {
    self.textLabel.text = title;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)heightForHeaderConstrainedByWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return self.textLabel.frame.origin.y + self.textLabel.frame.size.height + 8;
}

@end
