//
//  PTAppDelegate.h
//  ParseTest
//
//  Created by Alfonso Alba on 23/11/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTViewController;
@class PTGroupsNavController;

@interface PTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;

@end
