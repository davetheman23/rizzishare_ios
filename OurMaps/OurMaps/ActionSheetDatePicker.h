//
//  ActionSheetDatePicker.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "AbstractActionSheetPicker.h"

@class ActionSheetDatePicker;
typedef void(^ActionSheetDatePickerDoneBlock)(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin);
typedef void(^ActionSheetDatePickerCancelBlock)(ActionSheetDatePicker *picker);

@interface ActionSheetDatePicker : AbstractActionSheetPicker

+ (id)showPickerWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate target:(id)target action:(SEL)action origin:(id)origin;

- (id)initWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate target:(id)target action:(SEL)action origin:(id)origin;

+ (id)showPickerWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate doneBlock:(ActionSheetDatePickerDoneBlock)doneBlock cancelBlock:(ActionSheetDatePickerCancelBlock)cancelBlock origin:(id)origin;

- (id)initWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate doneBlock:(ActionSheetDatePickerDoneBlock)doneBlock cancelBlock:(ActionSheetDatePickerCancelBlock)cancelBlock origin:(id)origin;

- (void)eventForDatePicker:(id)sender;

@property (nonatomic, copy) ActionSheetDatePickerDoneBlock onActionSheetDone;
@property (nonatomic, copy) ActionSheetDatePickerCancelBlock onActionSheetCancel;

@end
