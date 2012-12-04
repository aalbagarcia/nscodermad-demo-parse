//
//  PTPersonCRUDDelegateProtocol.h
//  ParseTest
//
//  Created by Alfonso Alba on 04/12/12.
//  Copyright (c) 2012 Alfonso Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PTPersonCRUDDelegateProtocol <NSObject>

@required
- (void) addPerson:(NSDictionary *)data;


@end
