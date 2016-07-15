//
//  TNDBaseDBCoreData.h
//  iTienda
//
//  Created by PiciOS2016 on 7/13/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TNDBaseDBCoreData : NSObject

@property(nonatomic, strong, readonly) NSManagedObjectContext *context;

- (void)save;
- (void)delete:(NSManagedObject *)entity;
- (NSFetchRequest *)select:(Class)class;

@end
