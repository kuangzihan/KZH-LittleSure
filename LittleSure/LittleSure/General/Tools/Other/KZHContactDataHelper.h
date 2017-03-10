//
//  KZHContactDataHelper.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/1.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 格式化联系人列表 */

@interface KZHContactDataHelper : NSObject

+ (NSMutableArray *) getFriendListDataBy:(NSMutableArray *)array;
+ (NSMutableArray *) getFriendListSectionBy:(NSMutableArray *)array;

@end
