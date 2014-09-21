//
//  FKFormAttributeMapping.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "FKBlocks.h"

typedef enum {
    FKFormAttributeMappingTypeDefault = 0,
    FKFormAttributeMappingTypeTime = 1,
    FKFormAttributeMappingTypeDate = 2,
    FKFormAttributeMappingTypePassword = 3,
    FKFormAttributeMappingTypeLabel = 4,
    FKFormAttributeMappingTypeBoolean = 5,
    FKFormAttributeMappingTypeText = 6,
    FKFormAttributeMappingTypeFloat = 7,
    FKFormAttributeMappingTypeInteger = 8,
    FKFormAttributeMappingTypeDateTime = 9,
    FKFormAttributeMappingTypeSaveButton = 10,
    FKFormAttributeMappingTypeBigText = 11,
    FKFormAttributeMappingTypeImage = 12,
    FKFormAttributeMappingTypeButton = 13,
    FKFormAttributeMappingTypeSelect = 14,
    FKFormAttributeMappingTypeCustomCell = 15,
    FKFormAttributeMappingTypeSlider = 16,
    FKFormAttributeMappingTypeSeparator = 17
} FKFormAttributeMappingType;

@interface FKFormAttributeMapping : NSObject

@property (nonatomic, assign) FKFormAttributeMappingType mappingType;
@property (nonatomic, copy) NSString *attribute;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) FKFormAttributeMappingType type;
@property (nonatomic, copy) FKFormMappingSelectValueBlock selectValuesBlock;
@property (nonatomic, copy) FKFormMappingValueFromSelectBlock valueFromSelectBlock;
@property (nonatomic, copy) NSString *placeholderText;
@property (nonatomic, copy) FKBasicBlock saveBtnHandler;
@property (nonatomic, copy) FKFormMappingButtonHandlerBlock btnHandler;
@property (nonatomic, assign) UITableViewCellAccessoryType accesoryType;
@property (nonatomic, copy) NSString *dateFormat;
@property (nonatomic, copy) FKFormMappingDateFormatBlock dateFormatBlock;
@property (nonatomic, copy) FKFormMappingSelectLabelValueBlock labelValueBlock;
@property (nonatomic, copy) FKFormMappingWillDisplayCellBlock willDisplayCellBlock;
@property (nonatomic, copy) FKFormMappingCellSelectionBlock cellSelectionBlock;
@property (nonatomic, copy) FKFormMappingWillDisplayCellWithDataBlock willDisplayCellWithDataBlock;
@property (nonatomic, copy) FKFormMappingCellSelectionWithDataBlock cellSelectionWithDataBlock;
@property (nonatomic, assign) Class customCell;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) Class controllerClass;
@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) BOOL showInPicker;
@property (nonatomic, copy) FKFormMappingSliderValueBlock sliderValueBlock;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL hideLabel;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) NSTextAlignment valueTextAlignment;
@property (nonatomic, assign) BOOL clearsOnBeginEditing;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, assign) CGFloat separatorMargin;
@property (nonatomic, strong) id blockData;

/*
 * Convenient method to get an attributeMapping
 */
+ (id)attributeMapping;

@end
