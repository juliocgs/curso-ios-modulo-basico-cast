//
//  TNDBaseDBCoreData.m
//  iTienda
//
//  Created by PiciOS2016 on 7/13/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDBaseDBCoreData.h"
#import "TNDContextHelper.h"

@implementation TNDBaseDBCoreData

@synthesize context = _context;

- (instancetype)init{
    self = [super init];
    
    if(self != nil){
        _context = [TNDContextHelper getContext];
    }
    
    return self;
}

- (void)save{
    NSError *error = nil;
    
    [_context save:&error];
    
    if(error)
        NSLog(@"Erro ao salvar: %@", error.description);
}

- (void)delete:(NSManagedObject *)entity{
    NSError *error = nil;
    
    [_context delete:entity];
    [_context save:&error];
    
    if(error)
        NSLog(@"Erro ao deletar: %@", error.description);
}

- (NSFetchRequest *)select:(Class)class{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(class) inManagedObjectContext:_context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entity;
    
    return request;
}

@end
