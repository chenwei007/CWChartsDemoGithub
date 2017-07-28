//
//  DateValueFormatter.m
//  chenwei_charts
//
//  Created by MacBook on 2017/2/15.
//  Copyright © 2017年 xiao. All rights reserved.
//

#import "DateValueFormatter.h"

@interface DateValueFormatter()
{
    NSArray * _arr;
}
@end
@implementation DateValueFormatter
-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
//    PTTLog(@"当前%f----总个数%lu----%@",value,(unsigned long)_arr.count,axis)
    if ((NSInteger)value >= _arr.count) {
        return @"";
    }
    return _arr[(NSInteger)value];
}


@end

