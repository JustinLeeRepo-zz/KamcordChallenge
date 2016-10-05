//
//  NSString+JLUtils.h
//  KamcordChallenge
//
//  Created by Justin Lee on 9/28/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JLUtils)

/**
 *  Check whether this string is non-empty and has a length greater than zero.
 */
@property (assign, readonly, getter=isValidString) BOOL validString;

@end
