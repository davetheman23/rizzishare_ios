//
//  BubbleColor.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/29/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "BubbleColor.h"

@implementation BubbleColor

- (id)initWithGradientTop:(UIColor *)gradientTop gradientBottom:(UIColor *)gradientBottom border:(UIColor *)border {
    if (self = [super init]) {
        self.gradientTop = gradientTop;
        self.gradientBottom = gradientBottom;
        self.border = border;
    }
    return self;
}

@end
