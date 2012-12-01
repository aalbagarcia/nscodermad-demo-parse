//
//  PTAddGroupViewController.h
//  ParseTest
//
//  Created by Alfonso Alba on 27/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGroupDataSourceProtocol.h"
@interface PTAddGroupViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *groups;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) id<PTGroupCRUDDelegateProtocol> delegate;

- (IBAction)saveGroup:(UIButton *)sender;
@end
