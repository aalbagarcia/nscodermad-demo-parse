//
//  PTGroupsViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTGroupsViewController.h"
#import "PTAddGroupViewController.h"
#import "PTAppDelegate.h"
#import "PTGroupDetailViewController.h"
#import "PTGroupDetailNameTableViewCell.h"
#import <Parse/Parse.h>
@interface PTGroupsViewController ()

@end

@implementation PTGroupsViewController {
    NSArray *groups;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) initialization
{
    [self.tableView registerNib:[UINib nibWithNibName:@"StandardTableViewCell" bundle:nil] forCellReuseIdentifier:@"StandardCell"];
    [self getGroupsAndReloadDataInBackground];
    self.title = @"Groups";
    UIBarButtonItem *addGroupButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroupAction)];
    self.navigationItem.rightBarButtonItem = addGroupButton;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialization];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSourceProtocol

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [groups count];
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StandardCell" forIndexPath:indexPath];
    PFObject *group = [groups objectAtIndex:indexPath.row];
    cell.textLabel.text = [group objectForKey:@"name"];
    cell.detailTextLabel.text = @"";
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    PTGroupDetailViewController *detail = [[PTGroupDetailViewController alloc] init];
    PFObject *group = [groups objectAtIndex:indexPath.row];
    detail.group =group;
    detail.title = [group objectForKey:@"name"];
    
    [self.navigationController pushViewController:detail animated:YES];
}

-(BOOL) tableView:(UITableView *)tableView canDeleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *group = [groups objectAtIndex:indexPath.row];
        [group deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded & !error)
            {
                NSMutableArray *newGroups = [groups mutableCopy];
                [newGroups removeObjectAtIndex:indexPath.row];
                groups = [newGroups copy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];                
                });
            }
        }];
    }
}

#pragma mark Actions

- (void) addGroupAction
{
    NSLog(@"Add group button pressed");
    PTAddGroupViewController *addGroupViewController = [[PTAddGroupViewController alloc] init];
    addGroupViewController.delegate = self;
    [self.navigationController pushViewController:addGroupViewController  animated:YES];
}

#pragma mark PTGroupDataSourceProtocol
-(void) addGroup:(NSString *)group
{
    PFObject *newGroup = [PFObject objectWithClassName:@"Group"];
    [newGroup setObject:group forKey:@"name"];
    [newGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getGroupsAndReloadDataInBackground];
            });
            
        }
    }];
    NSLog(@"Saving group %@", group);
}

#pragma mark Parse Related Functions
- (void) getGroups
{
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    groups = [query findObjects];
}

- (void) getGroupsAndReloadDataInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    [query orderByAscending:@"name"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            groups = objects;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
}
@end
