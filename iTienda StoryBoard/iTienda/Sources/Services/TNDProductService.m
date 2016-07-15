//
//  TNDProductService.m
//  iTienda
//
//  Created by PiciOS2016 on 7/11/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDProductService.h"
#import "TNDProductJSONParser.h"
#import "TNDProductDBCoreData.h"

@interface TNDProductService(){
    TNDProductJSONParser *productParser;
    TNDProductDBCoreData *db;
}

@end

@implementation TNDProductService

- (instancetype)init{
    self = [super init];
    
    if(self != nil){
        productParser = [TNDProductJSONParser new];
        db = [TNDProductDBCoreData new];
    }
    
    return self;
}

- (void)getProductsByCategory:(NSString *)id callback:(void (^)(NSString *, NSMutableArray<TNDProduct> *))callback{
    NSArray<TNDProduct> *allProducts = [db getProductsByCategory:id];
    
    if(allProducts.count == 0){
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:self.productListURL, id]];
    
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error){
                NSMutableArray<TNDProduct> *products = [@[]mutableCopy];
                [productParser parseProducts:id products:products data:data];
                [db saveAll:products];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(error.description, products);
                });
            }
            else{
                callback(error.description, nil);
            }
        }];
    
        [task resume];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(nil, (NSMutableArray<TNDProduct> *)allProducts);
        });
    }
}

- (void)getProductPicture:(TNDProduct *)product callback:(void (^)(NSString *, TNDProduct *))callback{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:self.productDetailsURL, product.id]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            [product setPicture:[productParser parseProductPicture:product.id data:data]];
            [db save:product];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error.description, product);
            });
        }
        else{
            callback(error.description, nil);
        }
    }];
    
    [task resume];
}

- (void)getProductDescription:(TNDProduct *)product callback:(void (^)(NSString *, TNDProduct *))callback{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:self.productDescriptionURL, product.id]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            [product setDesc:[productParser parseProductDescription:product.id data:data]];
            [db save:product];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error.description, product);
            });
        }
        else{
            callback(error.description, nil);
        }
    }];
    
    [task resume];
}

@end
