//
//  FKFieldStyleProtocol.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FKFieldStyleProtocol <NSObject>

@optional

- (void)hideLabel;

- (void)setTextAlignment:(NSTextAlignment)textAlignment;

- (void)setValueTextAlignment:(NSTextAlignment)valueTextAlignment;

- (void)setLabelTextColor:(UIColor *)color;

- (void)setValueTextColor:(UIColor *)color;

@end
