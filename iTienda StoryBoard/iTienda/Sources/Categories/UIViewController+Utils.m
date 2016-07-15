//
//  UIViewController+Utils.m
//  PicAplicaticoCarro
//
//  Created by PiciOS2016 on 7/2/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

- (void) alertComTitulo:(NSString *)titulo mensagem:(NSString *)msg blocoResposta:(void (^)())bloco{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titulo message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:bloco];
    [alertController addAction:okAction];
    
    [self performSelectorOnMainThread:@selector(presentViewController:) withObject:alertController waitUntilDone:NO];
}

- (void) alertComTitulo:(NSString *)titulo mensagem:(NSString *)msg{
    [self alertComTitulo:titulo mensagem:msg blocoResposta:nil];
}

- (void) presentViewController:(UIViewController *) alert{
    [self presentViewController:alert animated:YES completion:nil];
}

@end
