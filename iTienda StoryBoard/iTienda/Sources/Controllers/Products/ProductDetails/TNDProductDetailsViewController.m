//
//  TNDProductDetailsViewController.m
//  iTienda
//
//  Created by PiciOS2016 on 7/12/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDProductDetailsViewController.h"
#import "TNDDownloadImageView.h"
#import "NSNumber+Utils.h"
#import "TNDProductService.h"

@interface TNDProductDetailsViewController (){
    TNDProductService *productService;
}

@property (weak, nonatomic) IBOutlet TNDDownloadImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TNDProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    productService = [TNDProductService new];
    
    self.navigationItem.title = self.product.title;
    self.priceLabel.text = [self.product.price toBrazilianCurrency];
    [self.webView loadHTMLString:[self createHTMLString:@"Carregando Descrição..."] baseURL:nil];
    
    if(!self.product.picture)
        [productService getProductPicture:self.product callback:^(NSString *error, TNDProduct *product) {
            if(!error)
                [self.imageView setURL:product.picture];
        }];
    else
        [self.imageView setURL:self.product.picture];
    
    if(!self.product.desc)
        [productService getProductDescription:self.product callback:^(NSString *error, TNDProduct *product) {
            if(!error)
                [self.webView loadHTMLString:[self createHTMLString:product.desc] baseURL:nil];
        }];
    else
        [self.webView loadHTMLString:[self createHTMLString:self.product.desc] baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buyButtonAction:(id)sender {
    NSURL *url = [NSURL URLWithString:self.product.permalink];
    
    if([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url];
}

- (NSString *)createHTMLString:(NSString *)string{
    NSMutableString *html = [NSMutableString stringWithString: @"<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><title></title><style type=\"text/css\">body{font-family: \"Arial\"} *{max-width: 100% !important;}</style></head><body style=\"background:transparent;\">"];
    [html appendString:string];
    [html appendString:@"</body></html>"];
    
    return [html description];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
