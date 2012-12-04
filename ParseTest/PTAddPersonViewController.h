//
//  PTAddPersonViewController.h
//  ParseTest
//
//  Created by Alfonso Alba on 04/12/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTPersonCRUDDelegateProtocol.h"
@interface PTAddPersonViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;

@property (strong, nonatomic) id<PTPersonCRUDDelegateProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *groupPicker;

@property (strong, nonatomic) NSArray *groups;

@end
