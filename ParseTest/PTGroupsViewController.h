//
//  PTGroupsViewController.h
//  ParseTest
//
//  Created by Alfonso Alba on 25/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGroupCRUDDelegateProtocol.h"
@interface PTGroupsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, PTGroupCRUDDelegateProtocol>

@end
