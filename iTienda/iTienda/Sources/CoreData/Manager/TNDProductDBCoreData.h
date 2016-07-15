//
//  TNDProductDBCoreData.h
//  iTienda
//
//  Created by PiciOS2016 on 7/13/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDBaseDBCoreData.h"
#import "TNDProduct.h"

@interface TNDProductDBCoreData : TNDBaseDBCoreData

- (NSArray<TNDProduct> *)getProductsByCategory:(NSString *)id;
- (void)save:(TNDProduct *)product;
- (void)saveAll:(NSArray<TNDProduct> *)products;

@end
