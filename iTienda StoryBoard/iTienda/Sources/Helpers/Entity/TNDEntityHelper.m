//
//  TNDEntityHelper.m
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDEntityHelper.h"
#import "TNDContextHelper.h"

@implementation TNDEntityHelper

+ (NSObject *)getInstanceOf:(Class)class{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(class) inManagedObjectContext:[TNDContextHelper getContext]];
}

@end
