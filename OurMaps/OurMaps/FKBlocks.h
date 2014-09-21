//
//  FKBlocks.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FKFormAttributeMapping;

typedef void(^FKBasicBlock)();

typedef NSArray *(^FKFormMappingSelectValueBlock)(id value, id object, NSInteger *selectedValueIndex);

typedef id(^FKFormMappingValueFromSelectBlock)(id value, id object, NSInteger selectedValueIndex);

typedef void(^FKFormMappingButtonHandlerBlock)(id object);

typedef NSString *(^FKFormMappingDateFormatBlock)();

typedef id (^FKFormMappingSelectLabelValueBlock)(id value, id object);

typedef void(^FKFormMappingWillDisplayCellBlock)(UITableViewCell *cell, id object, NSIndexPath *indexPath);

typedef void(^FKFormMappingCellSelectionBlock)(UITableViewCell *cell, id object, NSIndexPath *indexPath);

typedef NSString *(^FKFormMappingSliderValueBlock)(id value);

typedef void(^FKFormMappingDidChangeValueBlock)(id object, id value, NSString *keyPath);

typedef void(^FKFormMappingConfigureCellBlock)(UITableViewCell *cell);

typedef void(^FKFormMappingAttributeMappingBlock)(FKFormAttributeMapping *mapping);

typedef BOOL(^FKFormMappingIsValueValidBlock)(id value, id object);

typedef NSString *(^FKFormMappingFieldErrorStringBlock)(id value, id object);

typedef void(^FKFormMappingAttributeConfigurationBlock)(FKFormAttributeMapping *mapping);

typedef void(^FKFormMappingWillDisplayCellWithDataBlock)(UITableViewCell *cell, id object, NSIndexPath *indexPath, id data);

typedef void(^FKFormMappingCellSelectionWithDataBlock)(UITableViewCell *cell, id object, NSIndexPath *indexPath, id data);