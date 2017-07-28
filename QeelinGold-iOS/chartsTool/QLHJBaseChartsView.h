//
//  QLHJChartsView.h
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/5/20.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>

@interface QLHJBaseChartsView : UIView
@property (nonatomic, strong) LineChartView *myLineChartView;//折线图
@property (nonatomic ,strong) CombinedChartView *myBarCombinedChartView;//饼图集合
@property (nonatomic ,strong) CombinedChartView *myCandleStickCombinedChartView;//蜡烛图集合
//蜡烛图的数组
@property (nonatomic ,strong) NSMutableArray *candleArray;
//折线图的数组
@property (nonatomic ,strong) NSMutableArray *lineArray;

/**
 用作点击回调，场景是图例和laben上显示图标数据
 */
@property (nonatomic ,copy) void(^chartsViewBlock)(NSInteger index);

@end
