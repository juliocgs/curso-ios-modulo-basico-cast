//
//  TNDCategoryDBCoreData.m
//  iTienda
//
//  Created by PiciOS2016 on 7/13/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDCategoryDBCoreData.h"
#import <CoreData/CoreData.h>

@implementation TNDCategoryDBCoreData

- (NSArray<TNDCategory> *)getAll{
    NSFetchRequest *request = [self select:[TNDCategory class]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    NSError *error = nil;
    NSArray<TNDCategory> *categories = (NSArray<TNDCategory> *)[self.context executeFetchRequest:request error:&error];
    
    if(error)
        NSLog(@"Erro na consulta: %@", error.description);
    
    return categories;
}

- (void)save:(TNDCategory *)category{
    if(!category.timestamp)
        [category setTimestamp:[NSDate date]];
    
    [super save];
}

- (void)saveAll:(NSArray<TNDCategory> *)categories{
    for (TNDCategory *category in categories)
        [self save:category];
}

@end
