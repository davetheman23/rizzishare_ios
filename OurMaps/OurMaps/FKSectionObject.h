//
//  FKSectionObject.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface FKSectionObject : NSObject

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

+ (id)sectionWithHeaderTitle:(NSString *)title footerTitle:(NSString *)footerTitle;

@end
