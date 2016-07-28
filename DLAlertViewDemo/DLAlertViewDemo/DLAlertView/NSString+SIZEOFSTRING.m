//
//  NSString+SIZEOFSTRING.m
//  foundertimeIOS
//
//  Created by DavidLee on 15/12/4.
//  Copyright © 2015年 Benjamin Gordon. All rights reserved.
//
//  一个计算NSString宽高的分类

#import "NSString+SIZEOFSTRING.h"

@implementation NSString (SIZEOFSTRING)


-(CGSize)stringSizeWithFont:(UIFont*)font withMaxWidth:(CGFloat)maxWidth 
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
  
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
   
}

-(CGSize)stringSizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
