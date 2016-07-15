//
//  TNDCategoriesListViewController.m
//  iTienda
//
//  Created by PiciOS2016 on 7/10/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDCategoriesListViewController.h"
#import "TNDEntityHelper.h"
#import "TNDCategoryService.h"
#import "UIViewController+Utils.h"
#import "UITableView+Utils.h"
#import "TNDCustomTableViewCell.h"
#import "TNDProductListViewController.h"

@interface TNDCategoriesListViewController (){
    NSArray<TNDCategory> *categories;
    TNDCategoryService *categoryService;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end

@implementation TNDCategoriesListViewController
static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    categoryService = [TNDCategoryService new];
    [self loadCategories];
    
    self.navigationItem.title = @"Categorias";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TNDCustomTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCategories{
    categories = nil;
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    [view setAlpha:0.3];
    [self.view addSubview:view];
    
    [self.progress startAnimating];
    [categoryService getCategories:^(NSString *error, NSMutableArray<TNDCategory> *categoriesList) {
        if(error){
            [self alertComTitulo:@"Atenção" mensagem:error];
            [self.tableView showEmptyMessage:@"Desculpe-nos, houve em erro." controller:self];
        }
        else{
            categories = categoriesList;
            [self.tableView reloadData];
            [self.progress stopAnimating];
            [view removeFromSuperview];
            
            if(categories.count == 0)
                [self.tableView showEmptyMessage:@"Não há categorias." controller:self];
        }
    }];
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return categories.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TNDCategory *category = categories[indexPath.row];
    TNDCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setTitle:category.name];
    
    if(!category.picture)
        [categoryService getCategoryPicture:category callback:^(NSString *error, TNDCategory *categoryFromService) {
            if(!error)
                [cell setImageURL:categoryFromService.picture];
        }];
    else
        [cell setImageURL:category.picture];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"productListSegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TNDProductListViewController *productListViewController = segue.destinationViewController;
    [productListViewController setCategory:categories[[self.tableView indexPathForSelectedRow].row]];
}

@end
