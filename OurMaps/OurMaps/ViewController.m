//
//  ViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang, Wei Lu on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "ViewController.h"
#import "PlaceMarker.h"
#import "GooglePlacesAutocompleteQuery.h"
#import "NearbySearchQuery.h"
#import "GooglePlacesAutocompletePlace.h"
#import <Parse/Parse.h>

@interface ViewController () {
}
//@property (strong, nonatomic) GMSMapView *mapView;
@property (copy, nonatomic) NSSet *markers;
@property (strong, nonatomic) NSURLSession *markerSession;
@property (strong, nonatomic) PlaceMarker *userCreatedMarker;
@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    autoCompleteSearchQuery = [[GooglePlacesAutocompleteQuery alloc] init];
    autoCompleteSearchQuery.radius = 100.0;
    shouldBeginEditing = YES;


    nearbySearchQuery = [[NearbySearchQuery alloc] init];
    nearbySearchQuery.radius = 100.0;

    
    CLLocationCoordinate2D currentCoordinate = CLLocationCoordinate2DMake(40.714353, -74.005973);
//    NSLog(@"Current coordinate: %@", currentCoordinate);
	
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentCoordinate.latitude
                                                            longitude:currentCoordinate.longitude
                                                                 zoom:15
                                                              bearing:0
                                                         viewingAngle:0];
    self.mapView.camera = camera;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
//    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:18];
    //[self.view addSubview:self.mapView];
    
    //self.mapView.hidden=YES;
    
    self.mapView.delegate = self;
    
    self.usernameLabel.text = [[PFUser currentUser] username];
    
    //self.searchDisplayController.searchBar.placeholder = @"Search or Address";
    //self.searchDisplayController.searchBar.placeholder = @"Search or test";

    
    /***** Show user location *****/
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
//    marker.title = @"Current Location";
//    marker.snippet = @"New York City, USA";
//    marker.map = _mapView;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.714353, -74.005973);
    PlaceMarker *marker = [[PlaceMarker alloc] init];
    marker.position = coordinate;
    marker.title = @"Point of interest";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = nil;
    self.userCreatedMarker = marker;
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.URLCache = [[NSURLCache alloc] initWithMemoryCapacity:2*1024*1024
                                                    diskCapacity:10*1024*1024
                                                        diskPath:@"MarkerData"];
    self.markerSession = [NSURLSession sessionWithConfiguration:config];
    
    /***** Show places around the user location *****/
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSURL *url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=en&sensor=false&key=AIzaSyASvhdzIoZoDhTv0qayW_ybjYXnltaB8vc&radius=1000&keyword=mexican&location=40.714353,-74.005973"];
//        
//        NSData *responseData = [NSData dataWithContentsOfURL:url];
//        NSError *error;
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
//                                                             options:kNilOptions
//                                                               error:&error];
//        NSArray *results = json[@"results"];
//        for (int i = 0; i < [results count]; i++){
//            NSDictionary *place = [results objectAtIndex:i];
//            double lat = [place[@"geometry"][@"location"][@"lat"] doubleValue];
//            double lng = [place[@"geometry"][@"location"][@"lng"] doubleValue];
//            GMSMarker *marker = [[GMSMarker alloc] init];
//            marker.position = CLLocationCoordinate2DMake(lat, lng);
//            marker.title = @"Mexican";
//            marker.snippet = @"Customize this.";
//            marker.appearAnimation = kGMSMarkerAnimationPop;
////            marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
//            marker.icon = [UIImage imageNamed:@"fig_Coffee.png"];
//            marker.map = _mapView;
//        }
//        
//        /***** Google directions: get the route *****/
//        NSDictionary *routes = json[@"routes"][0];
//        NSDictionary *route = routes[@"overview_polyline"];
//        NSString *encodedPath = route[@"points"];
//        
//        GMSPath *path = [GMSPath pathFromEncodedPath:encodedPath];
//        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//        polyline.strokeWidth = 4;
//        polyline.strokeColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.7];
//        polyline.map = _mapView;
//        
//    });
    
    //self.searchBar.delegate = self;
    
    
    //self.autoCompleteTableView.delegate = self;
    
    
    [GMSServices openSourceLicenseInfo];
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [autocompleteNearbyPlaces count];
}

- (GooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [autocompleteNearbyPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"GooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)addGMSMarkerToMap:(CLPlacemark *)placemark addressString:(NSString *)address {
    
    if(self.userCreatedMarker != nil){
        self.userCreatedMarker.map = nil;
        self.userCreatedMarker = nil;
    }
    
    PlaceMarker *marker = [[PlaceMarker alloc] init];
    marker.position = placemark.location.coordinate;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.title = address;
    marker.map = nil;
    
    self.userCreatedMarker = marker;
    [self drawUserMarkers];
    
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    
    [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        if (error) {
            PresentAlertViewWithErrorAndTitle(error, @"Could not map selected Place");
        } else if (placemark) {
            [self addGMSMarkerToMap:placemark addressString:addressString];
            [self dismissSearchControllerWhileStayingActive];
            [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }];
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)nearbySearchForSearchString:(NSString *)searchString {
    
    autoCompleteSearchQuery.location = self.userCreatedMarker.position;
    autoCompleteSearchQuery.input = searchString;
    
    [autoCompleteSearchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            PresentAlertViewWithErrorAndTitle(error, @"Could not fetch places");
        } else {
            autocompleteNearbyPlaces = [places copy];
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    [self nearbySearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
     if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
        self.userCreatedMarker.map = nil;
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (shouldBeginEditing) {
        // Animate in the table view.
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
        [UIView commitAnimations];
        
        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}



#pragma mark -
#pragma mark Google Maps Delegate.

- (void)nearbySearchForCoordinate:(CLLocationCoordinate2D)coordinate {
    nearbySearchQuery.location = coordinate;
    
    NSLog(@"User location: (%f, %f)", nearbySearchQuery.location.latitude, nearbySearchQuery.location.longitude);
    
    [nearbySearchQuery fetchNearbyPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            PresentAlertViewWithErrorAndTitle(error, @"Could not fetch nearby places");
        } else {
            longPressNearbyPlaces = [places copy];
        }
        NSLog(@"Places count: %d", [longPressNearbyPlaces count]);
    }];
}


- (void)createMarkersWithPlaces {
    
    NSMutableSet *mutableMarkerSet = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < [longPressNearbyPlaces count]; i++){
        GooglePlacesAutocompletePlace *place = [longPressNearbyPlaces objectAtIndex:i];
        
        PlaceMarker *marker = [[PlaceMarker alloc] init];
        
        marker.objectID = place.identifier;
        marker.position = place.coordinate;
        marker.title = place.name;
        marker.snippet = [NSString stringWithFormat:@"Rating: %f, Price level: %d",place.rating, place.price_level];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        
        marker.icon = [UIImage imageNamed:@"fig_Coffee.png"];
        marker.map = nil;
        [mutableMarkerSet addObject:marker];
    }
    self.markers = [mutableMarkerSet copy];
    [self drawPlaceMarkers];
}

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    if(self.userCreatedMarker != nil){
        self.userCreatedMarker.map = nil;
        self.userCreatedMarker = nil;
    }
    
    GMSGeocoder *geocoder = [GMSGeocoder geocoder];
    [geocoder reverseGeocodeCoordinate:coordinate
                     completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
                         PlaceMarker *marker = [[PlaceMarker alloc] init];
                         marker.position = coordinate;
                         marker.appearAnimation = kGMSMarkerAnimationPop;
                         marker.title = response.firstResult.thoroughfare;
                         marker.snippet = response.firstResult.locality;
                         marker.map = nil;
                         
                         self.userCreatedMarker = marker;
                         [self drawUserMarkers];
                     }];
    
    [self nearbySearchForCoordinate:coordinate];
    [self createMarkersWithPlaces];
    
/*
    // Show places around the user's point of interests.
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=en&sensor=false&key=AIzaSyASvhdzIoZoDhTv0qayW_ybjYXnltaB8vc&radius=1000&keyword=mexican&location=%f,%f",coordinate.latitude,coordinate.longitude];
    NSURL *restaurantURL = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [self.markerSession dataTaskWithURL:restaurantURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self createMarkerObjectsWithJson:json];
        }];
    }];
    [task resume];
 */
}


- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{
    NSString *message = [NSString stringWithFormat:@"You tapped the info window for the %@ marker", marker.title];
    UIAlertView *windowTapped = [[UIAlertView alloc] initWithTitle:@"info Window Tapped!"
                                                           message:message
                                                          delegate:nil
                                                 cancelButtonTitle:@"Alright!"
                                                 otherButtonTitles:nil];
    
    [windowTapped show];
}


- (void)setupMarkerData{
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
    marker1.map = nil;
    
    self.markers = [NSSet setWithObjects:marker1, nil];
    [self drawPlaceMarkers];
}


- (void)createMarkerObjectsWithJson:(NSDictionary *)json {
    
    NSMutableSet *mutableMarkerSet = [[NSMutableSet alloc] init];
    
    NSArray *results = json[@"results"];
    for (int i = 0; i < [results count]; i++){
        NSDictionary *markerData = [results objectAtIndex:i];
        NSLog(@"MarkerData: %@",markerData);
        
        PlaceMarker *marker = [[PlaceMarker alloc] init];

        marker.objectID = markerData[@"id"];
        double lat = [markerData[@"geometry"][@"location"][@"lat"] doubleValue];
        double lng = [markerData[@"geometry"][@"location"][@"lng"] doubleValue];
        marker.position = CLLocationCoordinate2DMake(lat, lng);
        marker.title = markerData[@"name"];
        marker.snippet = [NSString stringWithFormat:@"Rating: %@, Price level: %@",markerData[@"rating"],markerData[@"price_level"]];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        
        marker.icon = [UIImage imageNamed:@"fig_Coffee.png"];
        marker.map = nil;
        [mutableMarkerSet addObject:marker];
    }
    self.markers = [mutableMarkerSet copy];
    [self drawPlaceMarkers];
}

- (void)drawUserMarkers{
    if(self.userCreatedMarker != nil && self.userCreatedMarker.map == nil){
        self.userCreatedMarker.map = self.mapView;
        self.mapView.selectedMarker = self.userCreatedMarker;
        GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:self.userCreatedMarker.position];
        [self.mapView animateWithCameraUpdate:cameraUpdate];
    }
}


- (void)drawPlaceMarkers{
    for(PlaceMarker *marker in self.markers){
        if(marker.map == nil){
            marker.map = self.mapView;
        }
    }
}


//- (void)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
//    if (mapView.myLocation != nil) {
//        NSString *urlString = [NSString stringWithFormat:@"%@?origin=%f,%f&destination=%f,%f&sensor=true&key=%@",
//                               @"https://maps.googleapis.com/maps/api/directions/json",
//                               mapView.myLocation.coordinate.latitude,
//                               mapView.myLocation.coordinate.longitude,
//                               marker.position.latitude,
//                               marker.position.longitude,
//                               @"AIzaSyASvhdzIoZoDhTv0qayW_ybjYXnltaB8vc"];
//        NSURL *directionsURL = [NSURL URLWithString:urlString];
//        NSURLSessionDataTask *directionsTask = [self.markerSession dataTaskWithURL:directionsURL
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *e) {
//                                                    NSError *error = nil;
//                                                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
//                                                                                                         options:NSJSONReadingMutableContainers
//                                                                                                           error:&error];
//                                                    if (!error) {
////                                                        self.steps = json[@"routes"][0][@"legs"][0][@"steps"];
//                                                    }
//                                                }];
//    }
//}


-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5,
                                            0,
                                            self.bottomLayoutGuide.length + 5,
                                            0);
}

//-(BOOL) prefersStatusBarHidden{
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
