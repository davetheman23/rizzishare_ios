//
//  NearbySearchQuery.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/6/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Utilities.h"

@interface NearbySearchQuery : NSObject{
    NSURLConnection *googleConnection;
    NSMutableData *responseData;
}


@property (nonatomic, copy, readonly) NearbySearchResultBlock resultBlock;

+ (NearbySearchQuery *)query;

/*!
 Pulls down places that match the query. If -fetchPlaces is called twice, the first request will be cancelled and the request will be re-issued using the current property values.
 */
- (void)fetchNearbyPlaces:(NearbySearchResultBlock)block;


#pragma mark -
#pragma mark Required parameters

/*!
 The application's API key. This key identifies our application for purposes of quota management. Visit the APIs Console to select an API Project and obtain your key. Maps API for Business customers must use the API project created for them as part of their Places for Business purchase. Defaults to kGoogleAPIKey.
 */
@property (nonatomic, retain) NSString *key;

/*!
 The point around which you wish to retrieve Place information.
 */
@property (nonatomic) CLLocationCoordinate2D location;

/*!
 The distance (in meters) within which to return Place results. Note that setting a radius biases results to the indicated area, but may not fully restrict results to the specified area.
 */
@property (nonatomic) CGFloat radius;

/*!
 The types of Place results to return. If no type is specified, all types will be returned.
 */
@property (nonatomic) GooglePlacesAutocompletePlaceType types;


#pragma mark -
#pragma mark Optional parameters

/*!
 Indicates whether or not the Place request came from a device using a location sensor (e.g. a GPS) to determine the location sent in this request. This value must be either true or false. Defaults to YES.
 */
@property (nonatomic) BOOL sensor;

/*!
 The language in which to return results. See the supported list of domain languages. Note that we often update supported languages so this list may not be exhaustive. If language is not supplied, the Place service will attempt to use the native language of the domain from which the request is sent.
 */
@property (nonatomic, retain) NSString *language;


@end
