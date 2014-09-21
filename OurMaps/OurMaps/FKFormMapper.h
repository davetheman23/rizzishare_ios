//
//  FKFormMapper.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import <Foundation/Foundation.h>

@class FKFormMapping;
@class FKFormAttributeMapping;
@class FKFormModel;

@interface FKFormMapper : NSObject <UITextFieldDelegate, UITextViewDelegate> {
    FKFormMapping *_formMapping;
    UITableView *_tableView;
    id _object;
    __weak FKFormModel *_formModel;
}

@property (nonatomic, readonly) FKFormMapping *formMapping;
@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) id object;
@property (nonatomic, readonly) FKFormModel *formModel;
@property (nonatomic, readonly) NSArray *titles;

- (id)initWithFormMapping:(FKFormMapping *)formMapping
                tabelView:(UITableView *)tableView
                   object:(id)object
                formModel:(FKFormModel *)formModel;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSString *)titleForHeaderInSection:(NSInteger)section;

- (NSString *)titleForFooterInSection:(NSInteger)sectionIndex;

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (FKFormAttributeMapping *)attributeMappingAtIndexPath:(NSIndexPath *)indexPath;

- (id)valueForAttributeMapping:(FKFormAttributeMapping *)attributeMapping;

- (void)setValue:(id)value forAttributeMapping:(FKFormAttributeMapping *)attributeMapping;

- (NSIndexPath *)indexPathOfAttributeMapping:(FKFormAttributeMapping *)attributeMapping;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)validateFieldWithAttribute:(NSString *)attribute;

@end
