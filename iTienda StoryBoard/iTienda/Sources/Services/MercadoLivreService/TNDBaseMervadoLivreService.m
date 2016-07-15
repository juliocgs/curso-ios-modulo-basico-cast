//
//  TNDBaseMervadoLivreService.m
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDBaseMervadoLivreService.h"
#import "NSString+Utils.h"

@implementation TNDBaseMervadoLivreService

@synthesize siteId = _siteId;
@synthesize categoryListURL = _categoryListURL;
@synthesize categoryDetailURL = _categoryDetailURL;
@synthesize productListURL = _productListURL;
@synthesize productDetailsURL = _productDetailsURL;
@synthesize productDescriptionURL = _productDescriptionURL;

- (instancetype)init{
    self = [super init];
    
    if(self != nil){
        // Código do Brasil
        _siteId = @"MLB";
        
        // Categorias do Brasil
        _categoryListURL = [NSString stringWithFormat:@"https://api.mercadolibre.com/sites/%@/categories", _siteId];
        
        // Detalhe da categoria
        _categoryDetailURL = @"https://api.mercadolibre.com/categories/%@";
        
        // Produtos por categoria, filtrando apenas lojas oficiais e produtos que possuem imagem. Também limitado a 20 produtos
        _productListURL = [[NSString stringWithFormat:@"https://api.mercadolibre.com/sites/%@", _siteId] concat:@"/search?category=%@&official_store_id=all&limit=20&has_pictures=yes"];
        
        // Detalhe do produto
        _productDetailsURL = @"https://api.mercadolibre.com/items/%@";
        
        // Descrição do produto
        _productDescriptionURL = [_productDetailsURL concat:@"/description"];
    }
    
    return self;
}

@end