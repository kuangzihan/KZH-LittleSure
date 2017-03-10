//
//  NSArray+Extension.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/1.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)


+ (NSArray *)setSectionLetter {
    NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:0];
    for(char c ='A';c<='Z';c++)
        
    {
        
        //当前字母
        
        NSString *zimu=[NSString stringWithFormat:@"%c",c];
        
        if (![zimu
              isEqualToString:@"I"]&&![zimu
                                       isEqualToString:@"O"]&&![zimu
                                                                isEqualToString:@"U"]&&![zimu isEqualToString:@"V"])
            
        {
            
            [sectionArray addObject:[NSString stringWithFormat:@"%c",c]];
            
        }
    }
    return sectionArray;
}


@end
