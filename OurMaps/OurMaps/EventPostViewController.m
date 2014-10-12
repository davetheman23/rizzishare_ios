//
//  EventPostViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/27/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import "EventPostViewController.h"

#import "FormKit.h"

#import "Movie.h"
#import "Event.h"
#import "Comment.h"
#import "Genre.h"
#import "LongTextViewController.h"

@implementation EventPostViewController

@synthesize formModel;
@synthesize movie = _movie;
@synthesize event = _event;

#pragma mark - View lifecycle


////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formModel = [FKFormModel formTableModelForTableView:self.tableView
                                        navigationController:self.navigationController];
    
    self.formModel.labelTextColor = [UIColor blackColor];
    self.formModel.valueTextColor = [UIColor lightGrayColor];
    self.formModel.topHeaderViewClass = [FKTitleHeaderView class];
    self.formModel.bottomHeaderViewClass = [FKTitleHeaderView class];
    
//    Event *event = [Event eventWithTitle:@"Play Poker"];
//    event.eventTime = [NSDate date];
//    event.eventPlace = @"SWEVI";
//    event.participants = nil;
//    self.event = event;
   
    
    [FKFormMapping mappingForClass:[Event class] block:^(FKFormMapping *formMapping) {
        [formMapping sectionWithTitle:@"Header" footer:@"Footer" identifier:@"info"];
        [formMapping mapAttribute:@"title" title:@"Title" type:FKFormAttributeMappingTypeText];

 
        [formMapping mappingForAttribute:@"eventTime"
                                   title:@"Event time"
                                    type:FKFormAttributeMappingTypeDate
                        attributeMapping:^(FKFormAttributeMapping *mapping) {
                            mapping.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                        }];

        [formMapping mapAttribute:@"eventPlace" title:@"Event place" type:FKFormAttributeMappingTypeText];
        
        [formMapping mapAttribute:@"participants"
                            title:@"Participants"
                     showInPicker:NO
                selectValuesBlock:^NSArray *(id value, id object, NSInteger *selectedValueIndex){
                    *selectedValueIndex = 1;
                    return self.event.participants;
//                    [NSArray arrayWithObjects:@"choice1", @"choice2", @"choice3", nil];
                    
                } valueFromSelectBlock:^id(id value, id object, NSInteger selectedValueIndex) {
                    return value;
                    
                } labelValueBlock:^id(id value, id object) {
                    return value;
                    
                }];
        
//        [formMapping sectionWithTitle:@"Custom cells" identifier:@"customCells"];
//        
//        [formMapping mapCustomCell:[FKDisclosureIndicatorAccessoryField class]
//                        identifier:@"custom"
//                         rowHeight:70
//                         blockData:@(1)
//              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath, id blockData) {
//                  cell.textLabel.text = [NSString stringWithFormat:@"I am a custom cell ! With blockData %@", [blockData description]];
//                  cell.textLabel.numberOfLines = 0;
//                  
//              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath, id blockData) {
//                  NSLog(@"You pressed me");
//                  
//              }];
//        
//        [formMapping mapCustomCell:[UITableViewCell class]
//                        identifier:@"custom2"
//              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
//                  cell.textLabel.text = @"I am a custom cell too !";
//                  
//              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
//                  NSLog(@"You pressed me");
//                  
//              }];
        
        [formMapping sectionWithTitle:@"Buttons" identifier:@"saveButton"];
        
        [formMapping buttonSave:@"Save" handler:^{
            NSLog(@"save pressed");
            NSLog(@"%@", self.event);
            [self.formModel save];
        }];
        
//        [formMapping validationForAttribute:@"custom" validBlock:^BOOL(id value, id object) {
//            return NO;
//        } errorMessageBlock:^NSString *(id value, id object) {
//            return @"Error";
//        }];
        
        [formMapping validationForAttribute:@"title" validBlock:^BOOL(NSString *value, id object) {
            return value.length < 10;
            
        } errorMessageBlock:^NSString *(id value, id object) {
            return @"Text is too long.";
        }];
        
        [formMapping validationForAttribute:@"releaseDate" validBlock:^BOOL(id value, id object) {
            return NO;
        }];
        
        [self.formModel registerMapping:formMapping];
    }];

    [self.formModel setDidChangeValueWithBlock:^(id object, id value, NSString *keyPath) {
        NSLog(@"did change model value");
    }];
    
//    [self.formModel loadFieldsWithObject:movie];
    [self.formModel loadFieldsWithObject:self.event];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.formModel = nil;
    self.movie = nil;
    self.event = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (IBAction)eventDidSave:(id)sender {
    PFObject *PFEvent = [Event eventToPFObject:self.event];
    [PFEvent saveInBackground];
    
}

@end