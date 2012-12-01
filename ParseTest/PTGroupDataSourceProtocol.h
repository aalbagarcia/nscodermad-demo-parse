//
//  PTGroupDataSourceProtocol.h
//  ParseTest
//
//  Created by Alfonso Alba on 01/12/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PTGroupCRUDDelegateProtocol <NSObject>

@required
- (void) addGroup:(NSString *)group;

@end
