//
//  ViewController.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/16/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    GMSMapView *mapView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.714353 longitude:-74.005973 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Show user location.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
    marker.title = @"Current Location";
    marker.snippet = @"Houston TX, USA";
    marker.map = mapView;
    
    // Show places around the user location.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=en&sensor=false&key=AIzaSyDjBPV3R5YT1jRV2ncL0eSfX6XMFieXGqc&radius=50000&keyword=mexican&location=40.714353,-74.005973"];
        
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:kNilOptions
                                                               error:&error];
        NSArray *results = json[@"results"];
        for (int i = 0; i < [results count]; i++){
            NSDictionary *place = [results objectAtIndex:i];
            double lat = [place[@"geometry"][@"location"][@"lat"] doubleValue];
            double lng = [place[@"geometry"][@"location"][@"lng"] doubleValue];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(lat, lng);
            marker.map = mapView;
        }
        
        // Google directions: get the route.
        NSDictionary *routes = json[@"routes"][0];
        NSDictionary *route = routes[@"overview_polyline"];
        NSString *encodedPath = route[@"points"];
        
        GMSPath *path = [GMSPath pathFromEncodedPath:encodedPath];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 4;
        polyline.strokeColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.7];
        polyline.map = mapView;
        
    });
    
    [GMSServices openSourceLicenseInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
