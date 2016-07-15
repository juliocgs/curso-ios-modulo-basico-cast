//
//  TNDProductJSONParser.h
//  iTienda
//
//  Created by PiciOS2016 on 7/12/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDProductJSONParser : NSObject

- (void)parseProducts:(NSString *)categoryId products:(NSMutableArray *)products data:(NSData *)data;
- (NSString *)parseProductPicture:(NSString *)productId data:(NSData *)data;
- (NSString *)parseProductDescription:(NSString *)productId data:(NSData *)data;

@end
