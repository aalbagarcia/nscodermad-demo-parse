//
//  PTPeopleViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTPeopleViewController.h"

@interface PTPeopleViewController ()

@end

@implementation PTPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"People";
        self.tabBarItem.image = [UIImage imageNamed:@"users"];
        
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

@end
