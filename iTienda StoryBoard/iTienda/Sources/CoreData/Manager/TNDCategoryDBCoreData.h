//
//  TNDCategoryDBCoreData.h
//  iTienda
//
//  Created by PiciOS2016 on 7/13/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDBaseDBCoreData.h"
#import "TNDCategory.h"

@interface TNDCategoryDBCoreData : TNDBaseDBCoreData

- (NSArray<TNDCategory> *)getAll;
- (void)save:(TNDCategory *)category;
- (void)saveAll:(NSArray<TNDCategory> *)categories;

@end
