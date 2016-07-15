//
//  UITableView+Utils.m
//  iTienda
//
//  Created by PiciOS2016 on 7/12/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "UITableView+Utils.h"

@implementation UITableView (Utils)

- (void)showEmptyMessage:(NSString *)message controller:(UIViewController *)controller{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, controller.view.bounds.size.width, controller.view.bounds.size.height)];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    
    self.backgroundView = label;
}

@end
