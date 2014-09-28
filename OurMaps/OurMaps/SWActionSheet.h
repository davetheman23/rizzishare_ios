//
//  SWActionSheet.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/28/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SWActionSheet : UIView
@property(nonatomic, strong) UIView *bgView;

- (void)dismissWithClickedButtonIndex:(int)i animated:(BOOL)animated;

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;

- (id)initWithView:(UIView *)view;

- (void)showInContainerView;
@end