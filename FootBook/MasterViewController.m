//
//  MasterViewController.m
//  FootBook
//
//  Created by Fletcher Rhoads on 1/29/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Friend.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *friendsArray;
    
    IBOutlet UITableView *friendsListTableView;
}

@end

@implementation MasterViewController
@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Friend"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"foo"];
    [self.fetchedResultsController performFetch:nil];
    self.fetchedResultsController.delegate = self;
    
    if (self.fetchedResultsController.fetchedObjects.count == 0)
    {
        [self pullDataFromJSON];
    }
}

-(void)pullDataFromJSON
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/3/friends.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        friendsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        
        for (NSString *name in friendsArray) {
            Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
            friend.name = name;
            friend.feet = @((arc4random()%3)+1);
            friend.shoesize = @((arc4random()%15)+1);

            [self.managedObjectContext save:nil];
        }
        [self.fetchedResultsController performFetch:nil];
        [friendsListTableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [friendsListTableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
    else if ([[segue identifier] isEqualToString:@"PartiesListIdentifier"]) {
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Parties"];
         request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        NSArray *arrayOfParties = [self.managedObjectContext executeFetchRequest:request error:nil];
//        if (array)
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = friend.name;
     cell.detailTextLabel.text = @(friend.comments.count).description;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        default:
            break;
    }
}


@end