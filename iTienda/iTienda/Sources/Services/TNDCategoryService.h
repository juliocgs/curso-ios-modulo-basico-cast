//
//  TNDCategoryService.h
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDBaseMervadoLivreService.h"
#import "TNDCategory.h"

@interface TNDCategoryService : TNDBaseMervadoLivreService

- (void)getCategories:(void (^)(NSString *, NSMutableArray<TNDCategory> *))callback;

- (void)getCategoryPicture:(TNDCategory *)category callback:(void (^)(NSString *, TNDCategory *))callback;

@end
