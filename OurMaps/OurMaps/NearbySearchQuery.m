//
//  NearbySearchQuery.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/6/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "NearbySearchQuery.h"
#import "GooglePlacesAutocompletePlace.h"

@interface NearbySearchQuery()
@property (nonatomic, copy, readwrite) NearbySearchResultBlock resultBlock;
@end


@implementation NearbySearchQuery

@synthesize sensor, key, location, radius, language, types, resultBlock;

+ (NearbySearchQuery *)query {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        // Setup default property values.
        self.sensor = YES;
        self.key = kGoogleAPIKey;
        self.location = CLLocationCoordinate2DMake(-1, -1);
        self.radius = NSNotFound;
        self.types = -1;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Nearby Search Query URL: %@", [self googleURLString]];
}


- (NSString *)googleURLString {
    NSMutableString *url = [NSMutableString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=%@&key=%@", BooleanStringForBool(sensor), key];
    if (location.latitude != -1) {
        [url appendFormat:@"&location=%f,%f", location.latitude, location.longitude];
    }
    if (radius != NSNotFound) {
        [url appendFormat:@"&radius=%f", radius];
    }
    if (language) {
        [url appendFormat:@"&language=%@", language];
    }
    if (types != -1) {
        [url appendFormat:@"&types=%@", PlaceTypeStringForPlaceType(types)];
    }
    return url;
}

- (void)cleanup {
    googleConnection = nil;
    responseData = nil;
    self.resultBlock = nil;
}

- (void)cancelOutstandingRequests {
    [googleConnection cancel];
    [self cleanup];
}

- (void)fetchNearbyPlaces:(NearbySearchResultBlock)block {
    //    if (!EnsureGoogleAPIKey()) {
    //        return;
    //    }
    
    [self cancelOutstandingRequests];
    self.resultBlock = block;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self googleURLString]]];
    googleConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    responseData = [[NSMutableData alloc] init];
    
}


#pragma mark -
#pragma mark NSURLConnectionDataDelegate

- (void)failWithError:(NSError *)error {
    if (self.resultBlock != nil) {
        self.resultBlock(nil, error);
    }
    [self cleanup];
}

- (void)succeedWithPlaces:(NSArray *)places {
    NSMutableArray *nearbyPlaces = [NSMutableArray array];
    for (NSDictionary *place in places) {
        [nearbyPlaces addObject:[GooglePlacesAutocompletePlace placeFromNearbySearchDictionary:place]];
    }
    if (self.resultBlock != nil) {
        self.resultBlock(nearbyPlaces, nil);
    }
    [self cleanup];
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (connection == googleConnection) {
        [responseData setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connnection didReceiveData:(NSData *)data {
    if (connnection == googleConnection) {
        [responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (connection == googleConnection) {
        [self failWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (connection == googleConnection) {
        NSError *error = nil;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (error) {
            [self failWithError:error];
            return;
        }
        if ([[response objectForKey:@"status"] isEqualToString:@"ZERO_RESULTS"]) {
            [self succeedWithPlaces:[NSArray array]];
            return;
        }
        if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
            [self succeedWithPlaces:[response objectForKey:@"results"]];
            return;
        }
        
        // Must have received a status of OVER_QUERY_LIMIT, REQUEST_DENIED or INVALID_REQUEST.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[response objectForKey:@"status"] forKey:NSLocalizedDescriptionKey];
        [self failWithError:[NSError errorWithDomain:@"ourmaps.ourmaps" code:kGoogleAPINSErrorCode userInfo:userInfo]];
    
    }
}

@end
