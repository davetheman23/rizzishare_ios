//
//  PlaceMarker.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 8/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "PlaceMarker.h"

@implementation PlaceMarker

- (BOOL)isEqual:(id)object {
    PlaceMarker *otherMarker = (PlaceMarker *)object;
    if(self.place_id == otherMarker.place_id) {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    return [self.place_id hash];
}

@end
