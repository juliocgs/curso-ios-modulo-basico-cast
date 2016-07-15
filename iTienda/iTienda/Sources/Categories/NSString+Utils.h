//
//  NSString+Utils.h
//  PicAplicaticoCarro
//
//  Created by PiciOS2016 on 7/2/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

//Remove os espaços e os caracteres \n do final da string
- (NSString*)trimAndNewLine;
//Concatena as string
- (NSString*)concat:(NSString*)string;
//Subistitui as ocorrências de uma string por outra string
- (NSString*)replace:(NSString*)string by:(NSString*)outraString;

@end
