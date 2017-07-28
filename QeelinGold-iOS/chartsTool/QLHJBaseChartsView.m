//
//  QLHJChartsView.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/5/20.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#import "QLHJBaseChartsView.h"
#import "QLChartsViews.h"

@interface QLHJBaseChartsView()<ChartViewDelegate>
@property (nonatomic ,assign) BOOL isShowMyBarNegativeMarker;
@property (nonatomic ,assign) BOOL isShowMyBarCombinedChartViewMarker;
@property (nonatomic ,assign) BOOL isShowMyCandleStickCombinedChartViewMarker;
@property (nonatomic ,assign) BOOL isShowChartViewMarker;
@end

@implementation QLHJBaseChartsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setUpView];

    }
    return self;
}
- (void)setUpView{
}
- (void)showMarkWith:(NSInteger)index withHight:(ChartHighlight*)highl{
    NSArray *newArr = self.candleArray[index];
    NSString *xStr = ((NSNumber *)(newArr.lastObject)).stringValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:xStr.floatValue / 1000];
    NSDateFormatter *df = [NSDateFormatter new];
    //    NSString *period = [self.parametsDic objectForKey:@"period"];
    BOOL isMinu = NO;
    //    if (period.integerValue>=1 && period.integerValue<=5) {
    //        isMinu = YES;
    //    }else{
    //        isMinu = NO;
    //    }
    if (isMinu) {
        [df setDateFormat:@"HH:mm"];//时间戳转成日期
    }else{
        [df setDateFormat:@"MM-dd"];//时间戳转成日期
    }
    NSString *  turnStr = [df stringFromDate:date];
    
    double high = ((NSNumber *)newArr[2]).doubleValue;
    double low = ((NSNumber *)newArr[3]).doubleValue;
    double open = ((NSNumber *)newArr[1]).doubleValue;
    double close = ((NSNumber *)newArr[4]).doubleValue;
    NSDictionary *dic = @{
                          @"time":turnStr,
                          @"open":[NSString stringWithFormat:@"%0.2f",open],
                          @"close":[NSString stringWithFormat:@"%0.2f",close],
                          @"high":[NSString stringWithFormat:@"%0.2f",high],
                          @"low":[NSString stringWithFormat:@"%0.2f",low]
                          };
    CandleChartDataEntry *entry =[[CandleChartDataEntry alloc]initWithX:index shadowH:high shadowL:low open:open close:close data:dic];
    ChartHighlight *highlll = [[ChartHighlight alloc]initWithX:entry.x y:entry.y dataSetIndex:highl.dataSetIndex];
    highlll.dataIndex = highl.dataIndex;
    NSArray *arr = @[highlll];
    [self.myCandleStickCombinedChartView highlightValues:arr];
}

- (void)setDragAndHighlightPerDragEnble:(BOOL)isEnble{
    [self.myBarCombinedChartView setDragEnabled:isEnble];
    [self.myCandleStickCombinedChartView setDragEnabled:isEnble];
    [self.myCandleStickCombinedChartView setHighlightPerDragEnabled:!isEnble];
    [self.myBarCombinedChartView setHighlightPerDragEnabled:!isEnble];
    [self.myLineChartView setDragEnabled:isEnble];
    [self.myLineChartView setHighlightPerDragEnabled:!isEnble];
}
- (void)chartValueHighterSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    double x = entry.x;
    NSInteger index = (NSInteger )x;
    [self setDragAndHighlightPerDragEnble:NO];
    self.isShowChartViewMarker = YES;
    NSArray *arr = @[highlight];
    [self.myLineChartView highlightValues:arr];
    [self.myBarCombinedChartView highlightValues:arr];
    [self.myCandleStickCombinedChartView highlightValues:arr];
    if (chartView == self.myBarCombinedChartView) {
        [self showMarkWith:index withHight:highlight];
    }
    if (self.chartsViewBlock) {
        self.chartsViewBlock(index);
    }

    if (chartView == self.myLineChartView) {
        
    }else if (chartView == self.myBarCombinedChartView){
        
    }else if (chartView == self.myCandleStickCombinedChartView){
        
    }
}
- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    double x = entry.x;
    NSInteger index = (NSInteger )x;
    PTTLog(@"%@----%d---index = %ld",chartView,self.isShowChartViewMarker,(long)index);
    if (self.isShowChartViewMarker) {
        self.isShowChartViewMarker = NO;
        [self.myLineChartView highlightValues:@[]];
        [self.myBarCombinedChartView highlightValues:@[]];
        [self.myCandleStickCombinedChartView highlightValues:@[]];
        [self setDragAndHighlightPerDragEnble:YES];
    }else{
        [self setDragAndHighlightPerDragEnble:NO];
        self.isShowChartViewMarker = YES;
        NSArray *arr = @[highlight];
        [self.myLineChartView highlightValues:arr];
        [self.myBarCombinedChartView highlightValues:arr];
        [self.myCandleStickCombinedChartView highlightValues:arr];
        if (chartView == self.myBarCombinedChartView) {
            [self showMarkWith:index withHight:highlight];
        }
        if (self.chartsViewBlock) {
            self.chartsViewBlock(index);
        }
    }
    if (chartView == self.myLineChartView) {
        
    }else if (chartView == self.myBarCombinedChartView){
        
    }else if (chartView == self.myCandleStickCombinedChartView){
        
    }
}
- (void)chartValueNothingSelected:(ChartViewBase *)chartView{
    self.isShowChartViewMarker = NO;
    [self.myLineChartView highlightValues:@[]];
    [self.myBarCombinedChartView highlightValues:@[]];
    [self.myCandleStickCombinedChartView highlightValues:@[]];
    [self setDragAndHighlightPerDragEnble:YES];

}
- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    
}
- (void)chartTranslated:(ChartViewBase *)chartView matrix:(CGAffineTransform)matrix{
    if (self.isShowChartViewMarker) {
        self.isShowChartViewMarker = NO;
        [self.myLineChartView highlightValues:@[]];
        [self.myBarCombinedChartView highlightValues:@[]];
        [self.myCandleStickCombinedChartView highlightValues:@[]];
        [self setDragAndHighlightPerDragEnble:YES];
    }
    if (chartView == self.myLineChartView) {

    }else if (chartView == self.myBarCombinedChartView){
        [self.myCandleStickCombinedChartView.viewPortHandler refreshWithNewMatrix:matrix chart:self.myCandleStickCombinedChartView invalidate:YES];
    }else if (chartView == self.myCandleStickCombinedChartView){
        [self.myBarCombinedChartView.viewPortHandler refreshWithNewMatrix:matrix chart:self.myBarCombinedChartView invalidate:YES];
    }
}

- (LineChartView *)myLineChartView{
    if (_myLineChartView == nil) {
        _myLineChartView = [QLChartsViews getMyLineChartView];
        _myLineChartView.delegate = self;
    }
    return _myLineChartView;
}
- (CombinedChartView *)myBarCombinedChartView{
    if (_myBarCombinedChartView == nil) {
        _myBarCombinedChartView = [QLChartsViews getMyCombinedChartsView:QLChartsViewsBar withPinchZoomEnabled:NO];
        _myBarCombinedChartView.delegate = self;
    }
    return _myBarCombinedChartView;
}
- (CombinedChartView *)myCandleStickCombinedChartView{
    if (_myCandleStickCombinedChartView == nil) {
        _myCandleStickCombinedChartView  = [QLChartsViews getMyCombinedChartsView:QLChartsViewsCandleStick withPinchZoomEnabled:NO];
        _myCandleStickCombinedChartView.delegate = self;
    }
    return _myCandleStickCombinedChartView;
}

@end
