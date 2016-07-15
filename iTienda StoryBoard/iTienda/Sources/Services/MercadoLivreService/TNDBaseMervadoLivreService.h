//
//  TNDBaseMervadoLivreService.h
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDBaseMervadoLivreService : NSObject

@property(nonatomic, strong, readonly) NSString *siteId;
@property(nonatomic, strong, readonly) NSString *categoryListURL;
@property(nonatomic, strong, readonly) NSString *categoryDetailURL;
@property(nonatomic, strong, readonly) NSString *productListURL;
@property(nonatomic, strong, readonly) NSString *productDetailsURL;
@property(nonatomic, strong, readonly) NSString *productDescriptionURL;

@end