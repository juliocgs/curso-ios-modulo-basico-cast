//
//  TNDProductJSONParser.m
//  iTienda
//
//  Created by PiciOS2016 on 7/12/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDProductJSONParser.h"
#import "TNDEntityHelper.h"
#import "TNDProduct.h"

@implementation TNDProductJSONParser
static NSString *ID = @"id";
static NSString *TITLE = @"title";
static NSString *PRICE = @"price";
static NSString *THUMBNAIL = @"thumbnail";
static NSString *PICTURES = @"pictures";
static NSString *PERMALINK = @"permalink";
static NSString *RESULTS = @"results";
static NSString *SECURE_URL = @"secure_url";
static NSString *TEXT = @"text";

- (void)parseProducts:(NSString *)categoryId products:(NSMutableArray *)products data:(NSData *)data{
    if (data.length > 0) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        if(!error){
            NSArray *results = dic[RESULTS];
            TNDProduct *product;
            for (NSDictionary *result in results) {
                product = (TNDProduct *)[TNDEntityHelper getInstanceOf:[TNDProduct class]];
                [product setId:result[ID]];
                [product setCategoryId:categoryId];
                [product setTitle:result[TITLE]];
                [product setPrice:result[PRICE]];
                [product setThumbnail:result[THUMBNAIL]];
                [product setPermalink:result[PERMALINK]];
                [products addObject:product];
            }
        }
        else{
            NSLog(@"Erro: %@", error.description);
        }
    }
}

- (NSString *)parseProductPicture:(NSString *)productId data:(NSData *)data{
    NSString *productPicture = @"";
    
    if (data.length > 0) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        if(!error){
            NSArray *pictures = dic[PICTURES];
            productPicture = pictures[0][SECURE_URL];
        }
    }
    
    return productPicture;
}

- (NSString *)parseProductDescription:(NSString *)productId data:(NSData *)data{
    NSString *productDescription = @"";
    
    if (data.length > 0) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        if(!error)
            productDescription = dic[TEXT];
    }
    
    return productDescription;
}

@end
