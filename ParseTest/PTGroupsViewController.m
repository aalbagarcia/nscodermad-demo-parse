//
//  PTGroupsViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTGroupsViewController.h"
#import "PTAddGroupViewController.h"
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
    [self getGroups];
    self.title = @"Groups";
    self.tabBarItem.image = [UIImage imageNamed:@"groups"];
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
    [newGroup save];
    [self getGroups];
    NSLog(@"Saving group %@", group);
    [self.tableView reloadData];
    
}

#pragma mark Parse Related Functions
- (void) getGroups
{
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    groups = [query findObjects];
}
@end
