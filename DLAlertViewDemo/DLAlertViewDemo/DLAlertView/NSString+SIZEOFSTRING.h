//
//  NSString+SIZEOFSTRING.h
//  foundertimeIOS
//
//  Created by DavidLee on 15/12/4.
//  Copyright © 2015年 Benjamin Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SIZEOFSTRING)

-(CGSize)stringSizeWithFont:(UIFont*)font withMaxWidth:(CGFloat)maxWidth;

-(CGSize)stringSizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;

@end
