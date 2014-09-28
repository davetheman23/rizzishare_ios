//
//  Genre.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject

@property (nonatomic, strong) NSString *name;

+ (id)genreWithName:(NSString *)name;

@end
