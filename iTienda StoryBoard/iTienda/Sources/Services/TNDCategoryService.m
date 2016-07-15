//
//  TNDCategoryService.m
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDCategoryService.h"
#import "TNDEntityHelper.h"
#import "TNDCategoryJSONParser.h"
#import "TNDCategoryDBCoreData.h"

@interface TNDCategoryService(){
    TNDCategoryJSONParser *categoryParser;
    TNDCategoryDBCoreData *db;
}

@end

@implementation TNDCategoryService

- (instancetype)init{
    self = [super init];
    
    if(self != nil){
        categoryParser = [TNDCategoryJSONParser new];
        db = [TNDCategoryDBCoreData new];
    }
    
    return self;
}

- (void)getCategories:(void (^)(NSString *, NSMutableArray<TNDCategory> *))callback{
    NSArray<TNDCategory> *allCategories = [db getAll];
    
    if(allCategories.count == 0){
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:self.categoryListURL];
    
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error){
                NSMutableArray<TNDCategory> *categories = [@[]mutableCopy];
                [categoryParser parseCategories:categories data:data];
                [db saveAll:categories];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(error.description, categories);
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
            callback(nil, (NSMutableArray<TNDCategory> *)allCategories);
        });
    }
}

- (void)getCategoryPicture:(TNDCategory *)category callback:(void (^)(NSString *, TNDCategory *))callback{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:self.categoryDetailURL, category.id]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [category setPicture:[categoryParser parseCategoryPicture:data]];
                [db save];
                callback(error.description, category);
            });
        }
        else{
            callback(error.description, nil);
        }
    }];
    
    [task resume];
}

@end
