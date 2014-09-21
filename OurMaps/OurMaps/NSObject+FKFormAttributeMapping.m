//
//  NSObject+FKFormAttributeMapping.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import "NSObject+FKFormAttributeMapping.h"

#import <objc/runtime.h>
#import "FKFormAttributeMapping.h"

static char FKFormAttributeMappingKey;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSObject (FKFormAttributeMapping)

@dynamic formAttributeMapping;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setFormAttributeMapping:(FKFormAttributeMapping *)formAttributeMapping {
    [self willChangeValueForKey:@"formAttributeMapping"];
    objc_setAssociatedObject(self, &FKFormAttributeMappingKey,
                             formAttributeMapping,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"formAttributeMapping"];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (FKFormAttributeMapping *)formAttributeMapping {
    return objc_getAssociatedObject(self, &FKFormAttributeMappingKey);
}


@end
