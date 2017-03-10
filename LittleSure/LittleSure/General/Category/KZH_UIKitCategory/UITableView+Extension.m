//
//  UITableView+Extension.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)tableViewNoDataOrNewworkFail:(NSInteger)rowCount{
    if (rowCount == 0) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"notfound"];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.bounds = self.bounds;
        self.backgroundView = imgView;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        self.backgroundView = nil;
    }
}

@end
