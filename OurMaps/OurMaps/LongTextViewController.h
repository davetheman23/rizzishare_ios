//
//  BWLongTextViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LongTextViewController : UIViewController

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) NSString *text;

- (id)initWithText:(NSString *)text;

@end
