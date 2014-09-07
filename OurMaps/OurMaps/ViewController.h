//
//  ViewController.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@class AutocompleteQuery;
@class NearbySearchQuery;
@class EventQuery;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, GMSMapViewDelegate> {
    
    NSArray *autocompleteNearbyPlaces;
    AutocompleteQuery *autocompleteQuery;
    BOOL shouldBeginEditing;

    NSArray *longPressNearbyPlaces;
    NearbySearchQuery *nearbySearchQuery;

    EventQuery *eventQuery;
}

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;


//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (weak, nonatomic) IBOutlet UITableView *autoCompleteTableView;

@end
