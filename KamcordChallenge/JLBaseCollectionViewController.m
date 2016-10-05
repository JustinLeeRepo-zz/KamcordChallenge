//
//  JLBaseCollectionViewController.m
//  KamcordChallenge
//
//  Created by Justin Lee on 9/27/16.
//  Copyright © 2016 JustinLee. All rights reserved.
//

#import "JLBaseCollectionViewController.h"

@interface JLBaseCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation JLBaseCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - Collection View Delegate Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = CGRectGetWidth(screenRect);
    CGSize cellSize;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        float cellWidth = (screenWidth - 5) / 5;
        cellSize = CGSizeMake(cellWidth, cellWidth);
    }
    else
    {
        float cellWidth = (screenWidth - 3) / 3;
        cellSize = CGSizeMake(cellWidth, cellWidth);
    }
    return cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

@end
