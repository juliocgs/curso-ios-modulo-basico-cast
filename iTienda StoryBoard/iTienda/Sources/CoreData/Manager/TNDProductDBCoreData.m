//
//  TNDProductDBCoreData.m
//  iTienda
//
//  Created by PiciOS2016 on 7/13/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDProductDBCoreData.h"

@implementation TNDProductDBCoreData

- (NSArray<TNDProduct> *)getProductsByCategory:(NSString *)id{
    NSFetchRequest *request = [self select:[TNDProduct class]];
    request.predicate = [NSPredicate predicateWithFormat:@"categoryId=%@", id];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    NSError *error = nil;
    NSArray<TNDProduct> *products = (NSArray<TNDProduct> *)[self.context executeFetchRequest:request error:&error];
    
    if(error)
        NSLog(@"Erro na consulta: %@", error.description);
    
    return products;
}

- (void)save:(TNDProduct *)product{
    if(!product.timestamp)
        [product setTimestamp:[NSDate date]];
    
    [super save];
    
}

- (void)saveAll:(NSArray<TNDProduct> *)products{
    for (TNDProduct *product in products)
        [self save:product];
}

@end
