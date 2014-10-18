//
//  EventPostViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/27/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//


#import "EventPostViewController.h"

#import "FormKit.h"

#import "Event.h"
#import "Comment.h"
#import "Genre.h"
#import "LongTextViewController.h"

UIBarButtonItem *joinButton;

@implementation EventPostViewController

@synthesize formModel;
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
    
    // Prepare for navigation bar
    joinButton = [[UIBarButtonItem alloc] initWithTitle:@"Join" style:UIBarButtonItemStyleDone target:self action:@selector(prepareForJoinRequest)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.saveButton, joinButton, nil];
    
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
        [formMapping sectionWithTitle:@"Event Details" footer:nil identifier:@"info"];
        [formMapping mapAttribute:@"title" title:@"Title" type:FKFormAttributeMappingTypeText];

 
        [formMapping mappingForAttribute:@"eventTime"
                                   title:@"Time"
                                    type:FKFormAttributeMappingTypeDateTime
                        attributeMapping:^(FKFormAttributeMapping *mapping) {
//                            mapping.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                            mapping.dateFormat = @"yyyy-MM-dd HH:mm";
                        }];

        [formMapping mapAttribute:@"eventPlace" title:@"Place" type:FKFormAttributeMappingTypeText];
        
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
        
        
        [formMapping buttonSave:@"Save" handler:^{
            NSLog(@"save pressed");
            NSLog(@"%@", self.event);
            [self.formModel save];
        }];
        
        
        [formMapping validationForAttribute:@"title" validBlock:^BOOL(NSString *value, id object) {
            return value.length < 100;
            
        } errorMessageBlock:^NSString *(id value, id object) {
            return @"Text is too long.";
        }];
        
        [formMapping validationForAttribute:@"eventTime" validBlock:^BOOL(id value, id object) {
            return NO;
        }];
        
        [self.formModel registerMapping:formMapping];
    }];

    [self.formModel setDidChangeValueWithBlock:^(id object, id value, NSString *keyPath) {
        NSLog(@"did change model value");
    }];
    
    [self.formModel loadFieldsWithObject:self.event];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.formModel = nil;
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

# pragma mark - prepare for join request
- (BOOL)shouldSendJoinRequest {
    if ([PFUser currentUser] != _event.owner) {
        return YES;
    }
    return NO;
}

- (void)prepareForJoinRequest {
    if ([self shouldSendJoinRequest]) {
        
        // Find corresponding event owner
        // Build the push notification target query
        PFQuery *pushQuery = [PFInstallation query];
        NSLog(@"owner: %@", _event.owner[@"displayName"]);
        [pushQuery whereKey:kInstallationUserKey equalTo:_event.owner];
        
        // Set push data
        NSString *message = [[NSString alloc] initWithFormat:@"%@ sent you a request to join %@",[[[PFUser currentUser] username] uppercaseString], _event.title];
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              message, @"alert",
                              nil];
        // Send push
        PFPush *push = [[PFPush alloc] init];
        [push setQuery:pushQuery];
        [push setData:data];
        [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (succeeded) {
                NSLog(@"request done");
                [self done:nil];
            }
        }];
    }
}

- (void)done:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Request Sent!"
                                                        message:@"Now do whatevet you want!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end