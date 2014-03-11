//
//  DetailViewController.m
//  FootBook
//
//  Created by Fletcher Rhoads on 1/29/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "DetailViewController.h"
#import "Friend.h"
#import "Comments.h"
@import CoreData;
#import "ChoosePhotoViewController.h"

@interface DetailViewController ()
{
    __weak IBOutlet UILabel *shoeSizeLabel;
    __weak IBOutlet UILabel *numberOfFeetLabel;
    
    IBOutlet UIButton *buttonWhichDisplaysImage;
    Friend *friend;
    IBOutlet UIButton *buttonToChooseAPhotoWhenPressed;
    UIImage *profilePicture;
    
    IBOutlet UITextField *textFieldContainingComments;
}

@end

@implementation DetailViewController
- (IBAction)onAddCommentsButtonPressed:(id)sender {
    Comments *newComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comments" inManagedObjectContext:friend.managedObjectContext];
    newComment.content = textFieldContainingComments.text;
    [textFieldContainingComments resignFirstResponder];
    [friend addCommentsObject:newComment];
    [friend.managedObjectContext save:nil];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    shoeSizeLabel.text = friend.shoesize.description;
	numberOfFeetLabel.text = friend.feet.description;
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    if ([friend.isPhtooAlreadyAdded  isEqual: @(1)]){
        buttonWhichDisplaysImage.selected = YES;
        profilePicture = [UIImage imageWithData:friend.image];
         [buttonWhichDisplaysImage setImage:profilePicture forState:UIControlStateSelected];
        
    }

}

#pragma mark - Managing the detail item

- (void)setDetailItem:(Friend *)chosenFriend
{
    friend = chosenFriend;
    self.title = friend.name;
}

- (IBAction)onProfileImageTapped:(id)sender
{
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 0, 5);
}


- (IBAction) unwindFromPhotoViewController : (UIStoryboardSegue *) segue {
    
    ChoosePhotoViewController *vc = segue.sourceViewController;
    
    
    profilePicture = vc.imageForProfilePicture;
    if (profilePicture != nil){
        buttonWhichDisplaysImage.selected = YES;
        [buttonWhichDisplaysImage setImage:profilePicture forState:UIControlStateSelected];
        NSData* pictureData = UIImageJPEGRepresentation(profilePicture, 1);
        friend.image = pictureData;
        [friend.managedObjectContext save:nil];
        NSLog (@"image = %@", friend.image);
        friend.isPhtooAlreadyAdded = @(1);
        
    }
    
    
    buttonToChooseAPhotoWhenPressed.alpha = 0;
    

    
}




@end
