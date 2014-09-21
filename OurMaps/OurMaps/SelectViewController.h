//
//  BWSelectViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectViewController;

typedef void(^BWSelectViewControllerDidSelectBlock)(NSArray *selectedIndexPaths, SelectViewController *controller);

@interface SelectViewController : UITableViewController

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) BWSelectViewControllerDidSelectBlock selectBlock;
@property (nonatomic, readonly) NSMutableArray *selectedIndexPaths;
@property (nonatomic, assign) BOOL multiSelection;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) BOOL allowEmpty;

- (id)initWithItems:(NSArray *)items
     multiselection:(BOOL)multiSelection
         allowEmpty:(BOOL)allowEmpty
      selectedItems:(NSArray *)selectedItems
        selectBlock:(BWSelectViewControllerDidSelectBlock)selectBlock;

- (void)setDidSelectBlock:(BWSelectViewControllerDidSelectBlock)didSelectBlock;

- (void)setSlectedIndexPaths:(NSArray *)selectedIndexPaths;

@end
