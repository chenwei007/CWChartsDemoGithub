//
//  QLHJTimeShareView.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/5/20.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#import "QLHJTimeShareChartsView.h"
#import "QLHJChartsHeader.h"
@implementation QLHJTimeShareChartsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setUpView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setDataForTimeShare];
        });

    }
    return self;
}
- (void)setUpView{
    [self addSubview:self.myLineChartView];
    [self.myLineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)setDataForTimeShare{
    NSString *linePath = [[NSBundle mainBundle] pathForResource:@"Documentsline" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:linePath];
    
    NSArray *arr = [[dic objectForKey:@"item"] objectForKey:@"datas"];
    NSArray *avgArr = [[dic objectForKey:@"item"]objectForKey:@"datas2"];
    if ([arr count] > 0 && [avgArr count] > 0) {
        QLChartsModel *chartsModel = [[QLChartsModel alloc]init];
        double hightestPrice = ((NSNumber *)[[dic objectForKey:@"item"]objectForKey:@"hightest"]).doubleValue;
        double yesterdayPrice = ((NSNumber *)[[dic objectForKey:@"item"]objectForKey:@"preclosing"]).doubleValue;
        double lowestPrice = ((NSNumber *)[[dic objectForKey:@"item"]objectForKey:@"lowest"]).doubleValue;
        chartsModel.yesterdayPrice = yesterdayPrice;
        //y轴的价格
        float cha = 0;
        float cha1 = fabs(hightestPrice - yesterdayPrice);
        float cha2 = fabs(lowestPrice - yesterdayPrice);
        if (cha1 >cha2) {
            cha = cha1;
        }else{
            cha = cha2;
        }
        //y轴的最大值和最小值
        float yHight = yesterdayPrice + cha*1.1;
        float yLow = yesterdayPrice - cha*1.1;
        //间隔
        float hightCha = (hightestPrice - yesterdayPrice)/3;
        
        float hightOne = yHight - hightCha ;
        float hightTwo =hightOne - hightCha;
        float lowOne = yesterdayPrice - hightCha;
        float lowTwo = lowOne - hightCha;
        NSArray *leftArray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:yHight],[NSNumber numberWithFloat:hightOne],[NSNumber numberWithFloat: hightTwo],[NSNumber numberWithFloat:yesterdayPrice],[NSNumber numberWithFloat:lowOne],[NSNumber numberWithFloat:lowTwo],[NSNumber numberWithFloat:yLow],nil];
        chartsModel.leftAxisArray = leftArray;
        
        NSNumber *one =[NSNumber numberWithDouble:((yHight - yesterdayPrice)/yesterdayPrice)];
        NSNumber *two = [NSNumber numberWithDouble:((hightOne - yesterdayPrice)/yesterdayPrice)];
        NSNumber *three = [NSNumber numberWithDouble:((hightTwo - yesterdayPrice)/yesterdayPrice)];
        NSNumber *zero = [NSNumber numberWithDouble:0.00];
        NSArray *rightArr = [NSArray arrayWithObjects:one,two,three,zero,[NSNumber numberWithDouble:((lowOne - yesterdayPrice)/yesterdayPrice)], [NSNumber numberWithDouble:((lowTwo - yesterdayPrice)/yesterdayPrice)],[NSNumber numberWithDouble:((yLow - yesterdayPrice)/yesterdayPrice)], nil];
        chartsModel.rightAxisArray = rightArr;
        
        chartsModel.LineChartDataSetOneArray = arr;
        chartsModel.LineChartDataSetTwoArray = avgArr;
        NSMutableArray *mArray = [self getDateWithOpenTime:@"2017-04-07 06:00:00" withCloseTime:@"2017-04-08 04:00:00"];
        chartsModel.xBottonAxisArray =(NSArray *)mArray;
        [[QLChartsTool shareManager] setupChartsModel:chartsModel withview:self.myLineChartView];
    }
}
- (NSMutableArray *)getDateWithOpenTime:(NSString *)openTime withCloseTime:(NSString *)closeTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //设置日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或UTC
    [dateFormatter setTimeZone:sourceTimeZone];
    NSDate *openT = [dateFormatter dateFromString:openTime];
    NSDate *closeT = [dateFormatter dateFromString:closeTime];
    NSMutableArray * xArray = [self transformTime:[openT timeIntervalSince1970] withNowTime:[closeT timeIntervalSince1970]];
    return xArray;
}
- (NSMutableArray *)transformTime:(long long) openTime withNowTime:(long long)closeTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *openDate = [NSDate dateWithTimeIntervalSince1970:openTime];
    NSDate *closeDate = [NSDate dateWithTimeIntervalSince1970:closeTime];
    NSDate *currentDate = openDate;
    NSMutableArray *arr = [NSMutableArray array];
    
    while ([closeDate timeIntervalSinceDate:currentDate]>0) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //设置日期时区
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或UTC
        [dateFormatter setTimeZone:sourceTimeZone];
        NSString *destDateString = [dateFormatter stringFromDate:currentDate];
        
        
        [arr addObject:[destDateString substringWithRange:NSMakeRange(11, 5)]];
        
        currentDate =  [currentDate dateByAddingTimeInterval:60];
        if ([currentDate timeIntervalSinceDate:closeDate]>0) {
            [dateFormatter setTimeZone:sourceTimeZone];
            //            NSString *destDateString = [dateFormatter stringFromDate:closeDate];
            [arr addObject:@""];
        }
    }
    return arr;
}

@end
