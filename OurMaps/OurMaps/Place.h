//
//  Place.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/24/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "PlaceMarker.h"

#import "Utilities.h"

@interface Place : NSObject{
    CLGeocoder *geocoder;
}

+ (Place *)placeFromAutocompleteDictionary:(NSDictionary *)placeDictionary;

+ (Place *)placeFromPlaceDetailDictionary:(NSDictionary *)placeDictionary;

+ (Place *)placeFromNearbySearchDictionary:(NSDictionary *)placeDictionary;

/*!
 Contains the human-readable name for the returned result. For establishment results, this is usually the business name.
 */
@property (nonatomic, retain, readonly) NSString *name;

/*!
 coordinate in (lat, lng).
 */
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, weak) PFGeoPoint *geoPoint;

@property (nonatomic, weak) NSMutableArray *eventArray;
@property (nonatomic, strong) PlaceMarker *placeMarker;

/*!
 Address, e.g., Level 5/48 Pirrama Rd, Pyrmont NSW, Australia.
 */
@property (nonatomic, retain, readonly) NSString *formatted_address;

/*!
 Phone number, e.g., (02) 9374 4000.
 */
@property (nonatomic, retain, readonly) NSString *formatted_phone_number;


/*!
 types[] is an array indicating the type of the address component.
 */
@property (nonatomic, retain, readonly) NSArray *types;

/*!
 Contains the primary 'type' of this place (i.e. "establishment" or "gecode").
 */
@property (nonatomic, readonly) GooglePlacesAutocompletePlaceType type;

/*!
 place_id is a unique identifier for a place. To retrieve information about the place, pass this identifier in the placeId field of a Places API request.
 */
@property (nonatomic, retain, readonly) NSString *place_id;


/*!
 The price level of the place, on a scale of 0 to 4. The exact amount indicated by a specific value will vary from region to region. Price levels are interpreted as follows:
 0 — Free
 1 — Inexpensive
 2 — Moderate
 3 — Expensive
 4 — Very Expensive
 */
@property (nonatomic, readonly) NSInteger price_level;

/*!
 rating contains the place's rating, from 1.0 to 5.0, based on user reviews.
 */
@property (nonatomic, readonly) float rating;

/*!
 open_now is a boolean value indicating if the place is open at the current time.
 */
@property (nonatomic, readonly) BOOL open_now;

/*!
 Resolves the place to a CLPlacemark, issuing Google Place Details request if needed.
 */
- (void)resolveToPlacemark:(GooglePlacesPlacemarkResultBlock)block;

/*!
 Query the place detail by issuing Google Place Details request.
 */
- (void)resolvePlaceIDToPlace:(PlaceDetailResultBlock)block;

@end
