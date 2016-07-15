//
//  TNDProductListViewController.h
//  iTienda
//
//  Created by PiciOS2016 on 7/11/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNDCategory.h"

@interface TNDProductListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) TNDCategory *category;

@end
