//
//  Comment.h
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;

+ (id)commentWithName:(NSString *)name comment:(NSString *)comment;

@end
