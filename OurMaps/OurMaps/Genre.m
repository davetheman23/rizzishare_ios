//
//  Genre.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Genre.h"

@implementation Genre

@synthesize name;

+ (id)genreWithName:(NSString *)newName {
    Genre *genre = [[Genre alloc] init];
    
    genre.name = newName;
    
    return genre;
}


@end
