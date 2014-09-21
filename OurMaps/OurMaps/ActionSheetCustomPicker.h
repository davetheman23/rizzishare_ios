//
//  ActionSheetCustomPicker.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractActionSheetPicker.h"
#import "ActionSheetCustomPickerDelegate.h"

@interface ActionSheetCustomPicker : AbstractActionSheetPicker
{
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
/////////////////////////////////////////////////////////////////////////
@property (nonatomic, strong) id<ActionSheetCustomPickerDelegate> delegate;


/////////////////////////////////////////////////////////////////////////
#pragma mark - Init Methods
/////////////////////////////////////////////////////////////////////////

/** Designated init */
- (id)initWithTitle:(NSString *)title delegate:(id<ActionSheetCustomPickerDelegate>)delegate showCancelButton:(BOOL)showCancelButton origin:(id)origin;

/** Convenience class method for creating an launched */
+ (id)showPickerWithTitle:(NSString *)title delegate:(id<ActionSheetCustomPickerDelegate>)delegate showCancelButton:(BOOL)showCancelButton origin:(id)origin;


@end
