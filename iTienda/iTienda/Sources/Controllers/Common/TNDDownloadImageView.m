//
//  PICDownloadImageView.m
//  PicAplicaticoCarro
//
//  Created by PiciOS2016 on 7/2/16.
//  Copyright © 2016 Cast Group. All rights reserved.
//

#import "TNDDownloadImageView.h"
#import "NSString+Utils.h"

@interface TNDDownloadImageView (){
    UIActivityIndicatorView *progress;
    NSOperationQueue *mainQueue;
    NSOperationQueue *queue;
}

@end

@implementation TNDDownloadImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    queue = [[NSOperationQueue alloc] init];
    mainQueue = [NSOperationQueue mainQueue];
    
    return [super initWithCoder:aDecoder];
}

- (void)createProgress{
    progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [progress setHidesWhenStopped:YES];
    [self addSubview:progress];
}

- (void)layoutSubviews{
    progress.center = [self convertPoint:self.center toView:self.superview];
}

- (void)setURL:(NSString *)url{
    [self createProgress];
    [self setUrl:url cache:YES];
    
}

- (void)setUrl:(NSString *)url cache:(BOOL) cache{
    self.image = nil;
    [queue cancelAllOperations];
    [progress startAnimating];
    [queue addOperationWithBlock:^{
        [self downloadImage:url cache:cache];
    }];
}

- (void)downloadImage:(NSString *)url cache:(BOOL) cache{
    NSData *data = nil;
    
    if(!cache){
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    }
    else{
        NSString *path = [url replace:@"/" by:@"_"];
        path = [path replace:@"\\" by:@"_"];
        path = [path replace:@":" by:@"_"];
        path = [[NSHomeDirectory() concat:@"/Documents/"] concat:path];
        
        BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
        
        if(exists){
            data = [NSData dataWithContentsOfFile:path];
        }
        else{
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [UIImage imageWithData:data];
            
            if(image != nil)
                [data writeToFile:path atomically:YES];
        }
    }
    
    [mainQueue addOperationWithBlock:^{
        [self showImage: data];
    }];
}

- (void)showImage:(NSData *)data{
    if (data.length > 0)
        self.image = [UIImage imageWithData:data];
    
    [progress stopAnimating];
}

@end
