//
//  Place.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/24/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Place.h"
#import "PlaceDetailQuery.h"


@interface Place()
@property (nonatomic, retain, readwrite) NSString *name;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain, readwrite) NSString *formatted_address;
@property (nonatomic, retain, readwrite) NSString *formatted_phone_number;

@property (nonatomic, retain, readwrite) NSString *place_id;

@property (nonatomic, retain, readwrite) NSArray *types;

@property (nonatomic, readwrite) GooglePlacesAutocompletePlaceType type;

@property (nonatomic, readwrite) NSInteger price_level;
@property (nonatomic, readwrite) float rating;
@property (nonatomic, readwrite) BOOL open_now;

@end

@implementation Place

@synthesize name, coordinate, formatted_address, formatted_phone_number, place_id, types, type, price_level, rating, open_now;



+ (Place *)placeFromParseObject:(PFObject *)anObject {
    
    Place *aPlace = [[Place alloc] init];
    
    aPlace.name = anObject[kPlaceNameKey];
    aPlace.place_id = anObject[kPlaceIdKey];
    aPlace.rating = [anObject[kPlaceOverallRatingKey] floatValue];
    PFGeoPoint *geoPoint = anObject[kPlaceGeoLocationKey];
    //aPlace.price_level = [
    
    double lat = geoPoint.latitude;
    double lng = geoPoint.longitude;
    aPlace.coordinate = CLLocationCoordinate2DMake(lat, lng);
    
    aPlace.eventArray = [NSMutableArray array];
    
    return aPlace;
}

+ (Place *)placeFromAutocompleteDictionary:(NSDictionary *)placeDictionary {
    Place *place = [[self alloc] init];
    place.name = [placeDictionary objectForKey:@"description"];
    place.place_id = [placeDictionary objectForKey:@"place_id"];
    place.type = PlaceTypeFromDictionary(placeDictionary);
    return place;
}

+ (Place *)placeFromPlaceDetailDictionary:(NSDictionary *)placeDictionary {
    Place *place = [[self alloc] init];
    place.name = [placeDictionary objectForKey:@"name"];
    place.place_id = [placeDictionary objectForKey:@"place_id"];

    place.formatted_address = [placeDictionary objectForKey:@"formatted_address"];
    place.formatted_phone_number = [placeDictionary objectForKey:@"formatted_phone_number"];
    place.types = [placeDictionary objectForKey:@"types"];
    
    double lat = [placeDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
    double lng = [placeDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
    place.coordinate = CLLocationCoordinate2DMake(lat, lng);
    
    place.price_level = [placeDictionary[@"price_level"] integerValue];
    place.rating = [placeDictionary[@"rating"] floatValue];
    place.open_now = [placeDictionary[@"opening_hours"][@"open_now"] boolValue];
    return place;
}


+ (Place *)placeFromNearbySearchDictionary:(NSDictionary *)placeDictionary {
    Place *place = [[self alloc] init];
    place.name = [placeDictionary objectForKey:@"name"];
    place.place_id = [placeDictionary objectForKey:@"place_id"];
    
    double lat = [placeDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
    double lng = [placeDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
    place.coordinate = CLLocationCoordinate2DMake(lat, lng);

    place.price_level = [placeDictionary[@"price_level"] integerValue];
    place.rating = [placeDictionary[@"rating"] floatValue];
    place.open_now = [placeDictionary[@"opening_hours"][@"open_now"] boolValue];

    place.eventArray = [NSMutableArray array];
    
    return place;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Place_ID: %@, Type: %@",
            name, place_id, PlaceTypeStringForPlaceType(type)];
}

- (CLGeocoder *)geocoder {
    if (!geocoder) {
        geocoder = [[CLGeocoder alloc] init];
    }
    return geocoder;
}

- (void)resolveEstablishmentPlaceToPlacemark:(GooglePlacesPlacemarkResultBlock)block {
    PlaceDetailQuery *placeDetailQuery = [PlaceDetailQuery query];
    placeDetailQuery.place_id = self.place_id;
    [placeDetailQuery fetchPlaceDetail:^(NSDictionary *placeDictionary, NSError *error) {
        if (error) {
            block(nil, nil, error);
        } else {
            NSString *addressString = [placeDictionary objectForKey:@"formatted_address"];
            [[self geocoder] geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
                if (error) {
                    block(nil, nil, error);
                } else {
                    CLPlacemark *placemark = [placemarks onlyObject];
                    block(placemark, self.name, error);
                }
            }];
        }
    }];
}

- (void)resolveGecodePlaceToPlacemark:(GooglePlacesPlacemarkResultBlock)block {
    [[self geocoder] geocodeAddressString:self.name completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            block(nil, nil, error);
        } else {
            CLPlacemark *placemark = [placemarks onlyObject];
            block(placemark, self.name, error);
        }
    }];
}

- (void)resolvePlaceIDToPlace:(PlaceDetailResultBlock)block {
    PlaceDetailQuery *placeDetailQuery = [PlaceDetailQuery query];
    placeDetailQuery.place_id = self.place_id;
    [placeDetailQuery fetchPlaceDetail:^(NSDictionary *placeDictionary, NSError *error) {
        if (error) {
            block(nil, error);
        } else {
            self.name = [placeDictionary objectForKey:@"name"];
            self.place_id = [placeDictionary objectForKey:@"place_id"];
            
            self.formatted_address = [placeDictionary objectForKey:@"formatted_address"];
            self.formatted_phone_number = [placeDictionary objectForKey:@"formatted_phone_number"];
            self.types = [placeDictionary objectForKey:@"types"];
            
            double lat = [placeDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
            double lng = [placeDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
            self.coordinate = CLLocationCoordinate2DMake(lat, lng);
            
            self.price_level = [placeDictionary[@"price_level"] integerValue];
            self.rating = [placeDictionary[@"rating"] floatValue];
            self.open_now = [placeDictionary[@"opening_hours"][@"open_now"] boolValue];

            block(self, error);
        }
    }];
}




//- (void)queryPlaceDetail:(PlaceDetailResultBlock)block {
//    if (type == PlaceTypeGeocode) {
//        // Geocode places already have their address stored in the 'name' field.
//        [self resolveGecodePlaceToPlacemark:block];
//    } else {
//        [self resolveEstablishmentPlaceToPlacemark:block];
//    }
//}

- (void)resolveToPlacemark:(GooglePlacesPlacemarkResultBlock)block {
    if (type == PlaceTypeGeocode) {
        // Geocode places already have their address stored in the 'name' field.
        [self resolveGecodePlaceToPlacemark:block];
    } else {
        [self resolveEstablishmentPlaceToPlacemark:block];
    }
}

- (NSUInteger)hash {
    return [self.place_id hash];
}

@end
