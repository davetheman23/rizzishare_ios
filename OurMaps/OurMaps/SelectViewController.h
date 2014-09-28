//
//  BWSelectViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectViewController;

typedef void(^SelectViewControllerDidSelectBlock)(NSArray *selectedIndexPaths, SelectViewController *controller);

@interface SelectViewController : UITableViewController

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) SelectViewControllerDidSelectBlock selectBlock;
@property (nonatomic, readonly) NSMutableArray *selectedIndexPaths;
@property (nonatomic, assign) BOOL multiSelection;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) BOOL allowEmpty;

- (id)initWithItems:(NSArray *)items
     multiselection:(BOOL)multiSelection
         allowEmpty:(BOOL)allowEmpty
      selectedItems:(NSArray *)selectedItems
        selectBlock:(SelectViewControllerDidSelectBlock)selectBlock;

- (void)setDidSelectBlock:(SelectViewControllerDidSelectBlock)didSelectBlock;

- (void)setSelectedIndexPaths:(NSArray *)selectedIndexPaths;

@end
