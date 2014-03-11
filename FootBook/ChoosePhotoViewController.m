//
//  ChoosePhotoViewController.m
//  FootBookActualGame
//
//  Created by Siddharth Sukumar on 1/30/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "ChoosePhotoViewController.h"
#import "PhotoCell.h"

@interface ChoosePhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    IBOutlet UICollectionView *myCollectionView;
    NSMutableArray *photos;
    NSArray *arrayContainingDictionariesOfheImagesAndTheirPaths;
    NSDictionary *dictionaryOfproficlePictureChosen;
   
}

@end

@implementation ChoosePhotoViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image1 = [UIImage imageNamed:@"bunny.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"ralph.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"Donald_duck.jpg"];
    photos = [[NSMutableArray alloc]initWithObjects:image1,image2, image3, nil];
    
    

	
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [myCollectionView dequeueReusableCellWithReuseIdentifier:@"PhotosReuseIdentifier" forIndexPath:indexPath];
    cell.imageView.image = photos [indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photos.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    if (!cell.isTheCellSelected){
        cell.contentView.backgroundColor = [UIColor greenColor];
        cell.isTheCellSelected = YES;
        self.imageForProfilePicture = cell.imageView.image;
        
    } else {
        cell.contentView.backgroundColor = [UIColor orangeColor];
        cell.isTheCellSelected = NO;
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    self.imageForProfilePicture = nil;
    
    
}

@end
