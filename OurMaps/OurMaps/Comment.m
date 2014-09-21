//
//  Comment.m
//  OurMaps
//
//  Created by Jiangchuan Huang on 9/21/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize name, comment;


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)commentWithName:(NSString *)newName comment:(NSString *)newComment {
    Comment *theComment = [[Comment alloc] init];
    
    theComment.name = newName;
    theComment.comment = newComment;
    
    return theComment;
}


@end
