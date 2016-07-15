//
//  UIViewController+Utils.h
//  PicAplicaticoCarro
//
//  Created by PiciOS2016 on 7/2/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

- (void) alertComTitulo:(NSString *) titulo mensagem:(NSString *) msg blocoResposta:(void (^)()) bloco;
- (void) alertComTitulo:(NSString *) titulo mensagem:(NSString *) msg;

@end
