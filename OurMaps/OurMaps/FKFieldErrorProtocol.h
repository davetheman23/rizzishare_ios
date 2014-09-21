//
//  FKFieldErrorProtocol.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FKFieldErrorProtocol <NSObject>

@required

- (void)addError:(NSString *)error;

- (void)setErrorTextColor:(UIColor *)color;

- (void)setErrorBackgroundColor:(UIColor *)color;

+ (CGFloat)errorHeightWithError:(NSString *)error tableView:(UITableView *)tableView;

@end
