//
//  TNDCustomTableViewCell.m
//  iTienda
//
//  Created by PiciOS2016 on 7/11/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDCustomTableViewCell.h"
#import "TNDDownloadImageView.h"

@interface TNDCustomTableViewCell()

@property (weak, nonatomic) IBOutlet TNDDownloadImageView *customImageView;
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *customSubTitleLabel;

@end

@implementation TNDCustomTableViewCell

- (void)setImageURL:(NSString *)url{
    [self.customImageView setURL:url];
}

- (void)setTitle:(NSString *)title{
    self.customTitleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle{
    self.customSubTitleLabel.text = subTitle;
}

- (void)awakeFromNib {
    self.customSubTitleLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
