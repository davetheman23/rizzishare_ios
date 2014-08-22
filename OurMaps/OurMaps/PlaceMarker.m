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
    if(self.objectID == otherMarker.objectID) {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    return [self.objectID hash];
}

@end
