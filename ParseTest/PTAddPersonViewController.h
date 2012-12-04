//
//  PTAddPersonViewController.h
//  ParseTest
//
//  Created by Alfonso Alba on 04/12/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTAddPersonViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;

@end
