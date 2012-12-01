//
//  PTAddGroupViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 27/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTAddGroupViewController.h"

@interface PTAddGroupViewController ()

@end

@implementation PTAddGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSLog(@"In textFieldShouldReturn");
    return YES;
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSLog(@"In textFieldShouldBeginEditing");
    return YES;
}

- (IBAction)saveGroup:(UIButton *)sender {
    [self.delegate addGroup:self.textField.text];
    [self.textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
