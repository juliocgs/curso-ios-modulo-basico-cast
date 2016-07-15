//
//  NSNumber+Utils.m
//  iTienda
//
//  Created by PiciOS2016 on 7/12/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "NSNumber+Utils.h"

@implementation NSNumber (Utils)

- (NSString *)toBrazilianCurrency{
    NSNumberFormatter *nf = [NSNumberFormatter new];
    [nf setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    return [nf stringFromNumber:self];
}

@end
