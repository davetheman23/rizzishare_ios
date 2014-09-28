//
//  FKFormAttributeMapping.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "FKFormAttributeMapping.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation FKFormAttributeMapping


////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.hideLabel = NO;
        self.textAlignment = NSTextAlignmentLeft;
        self.valueTextAlignment = NSTextAlignmentRight;
        self.clearsOnBeginEditing = NO;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.separatorMargin = CGFLOAT_MAX;
    }
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)attributeMapping {
    return [[self alloc] init];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setType:(FKFormAttributeMappingType)type {
    _type = type;
    
    if (FKFormAttributeMappingTypeFloat == type) {
        self.keyboardType = UIKeyboardTypeDecimalPad;
    } else if (FKFormAttributeMappingTypeInteger == type) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.keyboardType = UIKeyboardTypeDefault;
    }
}


@end
