//
//  BubbleColor.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/29/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BubbleColor : NSObject

@property (nonatomic, strong) UIColor *gradientTop;
@property (nonatomic, strong) UIColor *gradientBottom;
@property (nonatomic, strong) UIColor *border;

- (id)initWithGradientTop:(UIColor *)gradientTop gradientBottom:(UIColor *)gradientBottom border:(UIColor *)border;

@end
