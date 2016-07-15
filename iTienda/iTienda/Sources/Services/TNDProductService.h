//
//  TNDProductService.h
//  iTienda
//
//  Created by PiciOS2016 on 7/11/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDBaseMervadoLivreService.h"
#import "TNDProduct.h"

@interface TNDProductService : TNDBaseMervadoLivreService

- (void)getProductsByCategory:(NSString *)id callback:(void (^)(NSString *, NSMutableArray<TNDProduct> *))callback;

- (void)getProductPicture:(TNDProduct *)product callback:(void (^)(NSString *, TNDProduct *))callback;

- (void)getProductDescription:(TNDProduct *)product callback:(void (^)(NSString *, TNDProduct *))callback;

@end
