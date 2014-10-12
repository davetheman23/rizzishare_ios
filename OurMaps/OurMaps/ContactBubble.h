//
//  ContactBubble.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/29/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BubbleColor.h"

@class ContactBubble;

@protocol ContactBubbleDelegate <NSObject>

- (void)contactBubbleWasSelected:(ContactBubble *)contactBubble;
- (void)contactBubbleWasUnSelected:(ContactBubble *)contactBubble;
- (void)contactBubbleShouldBeRemoved:(ContactBubble *)contactBubble;

@end

@interface ContactBubble : UIView <UITextViewDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView; // used to capture keyboard touches when view is selected
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) id <ContactBubbleDelegate>delegate;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) BubbleColor *color;
@property (nonatomic, strong) BubbleColor *selectedColor;

- (id)initWithName:(NSString *)name;
- (id)initWithName:(NSString *)name
             color:(BubbleColor *)color
     selectedColor:(BubbleColor *)selectedColor;

- (void)select;
- (void)unSelect;
- (void)setFont:(UIFont *)font;

@end
