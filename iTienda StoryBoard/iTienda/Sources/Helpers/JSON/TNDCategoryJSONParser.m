//
//  TNDCategoryJSONParser.m
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDCategoryJSONParser.h"
#import "TNDEntityHelper.h"
#import "TNDCategory.h"

@implementation TNDCategoryJSONParser
static NSString *ID = @"id";
static NSString *NAME = @"name";
static NSString *PICTURE = @"picture";

- (void)parseCategories:(NSMutableArray *)categories data:(NSData *)data{
    if (data.length > 0) {
        NSError *error = nil;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        if(!error){
            TNDCategory *category;
            
            for (NSDictionary *dic in array) {
                category = (TNDCategory *)[TNDEntityHelper getInstanceOf:[TNDCategory class]];
                [category setId:dic[ID]];
                [category setName:dic[NAME]];
                
                [categories addObject:category];
            }
        }
        else{
            NSLog(@"Erro: %@", error.description);
        }
    }
}

- (NSString *)parseCategoryPicture:(NSData *)data{
    NSString *categoryPicture = @"";
    
    if (data.length > 0) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        if(!error){
            categoryPicture = dic[PICTURE];
        }
        else{
            NSLog(@"Erro: %@", error.description);
        }
    }
    
    return categoryPicture;
}

@end
