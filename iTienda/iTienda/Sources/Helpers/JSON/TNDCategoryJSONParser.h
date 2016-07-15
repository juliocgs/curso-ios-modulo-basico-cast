//
//  TNDCategoryJSONParser.h
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDCategoryJSONParser : NSObject

- (void)parseCategories:(NSMutableArray *)categories data:(NSData *)data;
- (NSString *)parseCategoryPicture:(NSData *)data;

@end
