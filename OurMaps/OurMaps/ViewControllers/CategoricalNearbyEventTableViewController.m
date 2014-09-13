//
//  CategoricalNearbyEventTableViewController.m
//  OurMaps
//
//  Created by Wei Lu on 9/11/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "CategoricalNearbyEventTableViewController.h"
#import <Parse/Parse.h>

@interface CategoricalNearbyEventTableViewController () {
    NSMutableArray *_nearbyEvents;
}

@property (nonatomic, strong) NSArray *eventTypeItems;

@end

@implementation CategoricalNearbyEventTableViewController

@synthesize nearbySearchQuery;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eventTypeItems = @[@"Food", @"Movie", @"Nightlife", @"Shopping", @"Gym", @"Spiritual"];
    self.currentCoordinate = CLLocationCoordinate2DMake(40.714353, -74.005973);
    
    /***** Initialize NearbySearchQuery *****/
    nearbySearchQuery = [[NearbySearchQuery alloc] init];
    nearbySearchQuery.radius = 100.0;
    
    if (_nearbyEvents == nil) {
        _nearbyEvents = [NSMutableArray array];
        [self nearbySearchForCoordinate:self.currentCoordinate];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)nearbySearchForCoordinate:(CLLocationCoordinate2D)coordinate {
    nearbySearchQuery.location = coordinate;
    
    [nearbySearchQuery fetchNearbyPlacesForEvents:^(NSArray *events, NSError *error) {
        if (error) {
            NSLog(@"Could not fetch nearby events!");
        } else {
            NSLog(@"Fetched %lu events nearby", events.count);
            _nearbyEvents = [events copy];
            [self classifyEvents:events];
            [self.tableView reloadData];
        }
    }];
}

- (void)classifyEvents:(NSArray *)eventArray {
    for (PFObject *event in eventArray) {
        NSString *typeKey = event[kEventTypeKey];
        if ([self respondsToSelector:NSSelectorFromString(typeKey)]) {
            NSDecimalNumber *value = [self valueForKey:typeKey];
            //NSDecimalNumber *one = @1;
            [value decimalNumberByAdding:[NSDecimalNumber one]];
            //id value_new = (id)value;
            [self setValue:value forKey:typeKey];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.eventTypeItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoricalNearbyEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.type = [self.eventTypeItems objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
