//
//  PTGroupDetailViewController.h
//  ParseTest
//
//  Created by Alfonso Alba on 04/12/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PFObject;

@interface PTGroupDetailViewController : UITableViewController

@property (strong, nonatomic) PFObject *group;
@property (strong, nonatomic) NSArray *members;

@end
