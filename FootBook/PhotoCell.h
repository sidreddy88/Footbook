//
//  PhotoCell.h
//  FootBookActualGame
//
//  Created by Siddharth Sukumar on 1/30/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL isTheCellSelected;

@end
