//
//  PTAddPersonViewController.m
//  ParseTest
//
//  Created by Alfonso Alba on 04/12/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import "PTAddPersonViewController.h"
#import <Parse/Parse.h>
@interface PTAddPersonViewController ()

@end

@implementation PTAddPersonViewController

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
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(savePersonAction:)];
    self.navigationItem.rightBarButtonItem = done;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
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


#pragma mark Actions
- (void) savePersonAction:(id)sender
{
    NSLog(@"Saving person");
    PFObject *person = [PFObject objectWithClassName:@"Person"];
    [person setObject:self.firstNameTextField.text forKey:@"firstName"];
    [person setObject:self.lastNameTextField.text forKey:@"lastName"];
    [person setObject:self.emailTextField.text forKey:@"email"];
    [person setObject:self.twitterTextField.text forKey:@"twitter"];
    [person saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            NSLog(@"Person could not be saved.");
        }
    }];
}

- (void) dismissKeyboard
{
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.twitterTextField resignFirstResponder];
}
@end
