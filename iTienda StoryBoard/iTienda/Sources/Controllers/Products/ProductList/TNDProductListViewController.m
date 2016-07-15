//
//  TNDProductListViewController.m
//  iTienda
//
//  Created by PiciOS2016 on 7/11/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDProductListViewController.h"
#import "TNDProductDetailsViewController.h"
#import "TNDCustomTableViewCell.h"
#import "TNDProduct.h"
#import "TNDProductService.h"
#import "UIViewController+Utils.h"
#import "NSNumber+Utils.h"
#import "UITableView+Utils.h"

@interface TNDProductListViewController (){
    NSMutableArray<TNDProduct> *products;
    TNDProductService *productService;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end

@implementation TNDProductListViewController
static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.category.name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    productService = [TNDProductService new];
    [self loadProducts];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TNDCustomTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadProducts{
    products = nil;
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    [view setAlpha:0.3];
    [self.view addSubview:view];
    
    [self.progress startAnimating];
    [productService getProductsByCategory:self.category.id callback:^(NSString *error, NSMutableArray<TNDProduct> *productsList) {
        if(error){
            [self alertComTitulo:@"Atenção" mensagem:error];
            [self.tableView showEmptyMessage:@"Desculpe-nos, houve em erro." controller:self];
        }
        else{
            products = productsList;
            [self.tableView reloadData];
            [self.progress stopAnimating];
            [view removeFromSuperview];
            
            if(products.count == 0)
                [self.tableView showEmptyMessage:@"Categoria vazia." controller:self];
        }
    }];
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return products.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TNDProduct *product = products[indexPath.row];
    TNDCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setTitle:product.title];
    [cell setSubTitle:[product.price toBrazilianCurrency]];
    [cell setImageURL:product.thumbnail];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"productDetailSegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TNDProductDetailsViewController *productDetailsViewController = segue.destinationViewController;
    [productDetailsViewController setProduct:products[[self.tableView indexPathForSelectedRow].row]];
}


@end
