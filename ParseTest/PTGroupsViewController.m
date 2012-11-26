//
//  PTGroupsViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTGroupsViewController.h"

@interface PTGroupsViewController ()

@end

@implementation PTGroupsViewController {
    NSArray *groups;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"StandardTableViewCell" bundle:nil] forCellReuseIdentifier:@"StandardCell"];
        groups = [NSArray arrayWithObjects:@"grupo1",@"grupo2", nil];
        self.title = @"Groups";
        self.tabBarItem.image = [UIImage imageNamed:@"groups"];
        UIBarButtonItem *addGroupButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"circle_plus.png"] style:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
        self.navigationItem.rightBarButtonItem = addGroupButton;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    cell.textLabel.text = [groups objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"";
    return cell;
}


- (void) addGroup
{
    NSLog(@"Add group button pressed");
}
@end
