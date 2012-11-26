//
//  PTViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTViewController.h"
#import "PTGroupsNavController.h"
#import "PTPeopleViewController.h"
#import "PTGroupsViewController.h"

@interface PTViewController ()

@end

@implementation PTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarController = [[UITabBarController alloc] init];
        PTGroupsViewController *groupsVC = [[PTGroupsViewController alloc] initWithNibName:@"PTGroupsViewController" bundle:nil];
        UINavigationController *navigationController = [[PTGroupsNavController alloc] initWithRootViewController:groupsVC];
        PTPeopleViewController *peopleVC = [[PTPeopleViewController alloc] initWithNibName:@"PTPeopleViewController" bundle:nil];
        
        self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController, peopleVC, nil];
        [self.view addSubview:self.tabBarController.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
