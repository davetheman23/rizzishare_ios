//
//  ContactPickerView.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/29/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactBubble.h"

@class ContactPickerView;

@protocol ContactPickerDelegate <NSObject>

- (void)contactPickerTextViewDidChange:(NSString *)textViewText;
- (void)contactPickerDidRemoveContact:(id)contact;
- (void)contactPickerDidResize:(ContactPickerView *)contactPickerView;

@end

@interface ContactPickerView : UIView <UITextViewDelegate, ContactBubbleDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) ContactBubble *selectedContactBubble;
@property (nonatomic, assign) IBOutlet id <ContactPickerDelegate> delegate;
@property (nonatomic, assign) BOOL limitToOne;
@property (nonatomic, assign) CGFloat viewPadding;
@property (nonatomic, strong) UIFont *font;

- (void)addContact:(id)contact withName:(NSString *)name;
- (void)removeContact:(id)contact;
- (void)removeAllContacts;
- (void)setPlaceholderString:(NSString *)placeholderString;
- (void)disableDropShadow;
- (void)resignKeyboard;
- (void)setBubbleColor:(BubbleColor *)color selectedColor:(BubbleColor *)selectedColor;
    
@end
