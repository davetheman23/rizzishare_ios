//
//  FKTitleHeaderViewProtocol.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FKTitleHeaderViewProtocol <NSObject>

- (void)setHeaderTitle:(NSString *)title;

- (CGFloat)heightForHeaderConstrainedByWidth:(CGFloat)width;

@end
