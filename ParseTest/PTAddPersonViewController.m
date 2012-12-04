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

#pragma marck UIPickerViewDataSource

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.groups count];
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    PFObject *group = [self.groups objectAtIndex:row];
    return [group objectForKey:@"name"];
}

#pragma mark Actions
- (void) savePersonAction:(id)sender
{
    NSLog(@"Saving person");
    NSInteger selectedGroupRow = [self.groupPicker selectedRowInComponent:0];
    NSArray *objects = [NSArray arrayWithObjects:self.firstNameTextField.text, self.lastNameTextField.text, self.emailTextField.text, self.twitterTextField.text, [self.groups objectAtIndex:selectedGroupRow], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"firstName",@"lastName",@"email",@"twitter",@"group", nil];
    NSDictionary *data = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [self.delegate addPerson:data];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) dismissKeyboard
{
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.twitterTextField resignFirstResponder];
}

@end
