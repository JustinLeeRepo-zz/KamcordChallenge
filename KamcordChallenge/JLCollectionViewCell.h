//
//  JLCollectionViewCell.h
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLShot.h"

@interface JLCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) JLShot *shot;

+ (NSString *)reuseIdentifier;

@end
