//
//  FKFormAttributeValidation.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FKBlocks.h"

@interface FKFormAttributeValidation : NSObject

@property (nonatomic, copy) NSString *attribute;
@property (nonatomic, copy) FKFormMappingIsValueValidBlock valueValidBlock;
@property (nonatomic, copy) FKFormMappingFieldErrorStringBlock errorMessageBlock;

/*
 * Convenient method to get an attributeValidation
 */
+ (id)attributeValidation;

@end
