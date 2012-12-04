//
//  PTPeopleViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTPeopleViewController.h"
#import "PTAddPersonViewController.h"
#import <Parse/Parse.h>

@interface PTPeopleViewController ()
{
    NSArray *people;
    NSArray *groups;
}
@end

@implementation PTPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void) initializacion
{
    self.title = @"People";
    UIBarButtonItem *addPersonButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPersonAction:)];
    self.navigationItem.rightBarButtonItem = addPersonButton;
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonCell"];
    [self loadDataInBackground];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializacion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [people count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    PFObject *person = [people objectAtIndex:indexPath.row];
    NSString *name = [[person objectForKey:@"firstName" ] stringByAppendingString:@" "];
    name = [name stringByAppendingString:[person objectForKey:@"lastName"]];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = @"GROUP";
    return cell;
}

#pragma mark Parse Related Functions

- (void) loadDataInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query orderByAscending:@"firstName"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            people = objects;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
}

#pragma mark Actions

- (void) addPersonAction:(id) sender
{
    NSLog(@"Add person pressed");
    UIStoryboard *tableViewStoryboard = [UIStoryboard storyboardWithName:@"PTAddPersonViewController" bundle:nil];
    PTAddPersonViewController *viewController = [tableViewStoryboard instantiateViewControllerWithIdentifier:@"PTAddPersonViewController"];
    viewController.delegate = self;
    PFQuery *groupsQuery = [PFQuery queryWithClassName:@"Group"];
    [groupsQuery orderByAscending:@"name"];
    [groupsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        groups = objects;
        viewController.groups = groups;
        [self.navigationController pushViewController:viewController animated:YES];
    }];

}

#pragma mark PTPersonCRUDDelegateProtocol

- (void) addPerson:(NSDictionary *)data
{
    PFObject *group = [data objectForKey:@"group"];
    PFObject *person = [PFObject objectWithClassName:@"Person"];
    [person setObject:[data objectForKey:@"firstName"] forKey:@"firstName"];
    [person setObject:[data objectForKey:@"lastName"] forKey:@"lastName"];
    [person setObject:[data objectForKey:@"email"] forKey:@"email"];
    [person setObject:[data objectForKey:@"twitter"] forKey:@"twitter"];
    PFRelation *memberOf = [person relationforKey:@"memberOf"];
    [memberOf addObject:group];
    [person saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadDataInBackground];
            });
            
            //We cannot create the inverse relation until the object is saved
            PFRelation *relation = [group relationforKey:@"members"];
            [relation addObject:person];
            [group saveInBackground];
        }
        else
        {
            NSLog(@"Person could not be saved.");
        }
    }];
}
@end