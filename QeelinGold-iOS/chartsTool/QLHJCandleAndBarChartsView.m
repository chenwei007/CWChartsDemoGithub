
//
//  QLHJCandleAndBarView.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/5/20.
//  Copyright © 2017年 ChenWei. All rights reserved.
//

#import "QLHJCandleAndBarChartsView.h"
#import "QLHJChartsHeader.h"    
#import "QLChartsDataCategoryView.h"
@interface QLHJCandleAndBarChartsView()
@property (nonatomic ,strong) UILabel *myBarNegativeViewLabel;
@property (nonatomic ,strong) UILabel *myCandleStickChartsViewLabel;

@property (nonatomic ,strong) NSMutableArray *chartslineExtArr;
@property (nonatomic ,strong) NSMutableArray *chartsbaseLineArr;
@property (nonatomic ,strong) NSDictionary *parametsDic;


@end

@implementation QLHJCandleAndBarChartsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setUpView];
        
        [self setDataForBar];
    }
    return self;
}
- (void)setUpView{
    
    [self addSubview:self.myBarCombinedChartView];
    [self.myBarCombinedChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@100);
        make.bottom.equalTo(self);
    }];
    
    [self addSubview:self.myBarNegativeViewLabel];
    [self.myBarNegativeViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.top.equalTo(self.myBarCombinedChartView.mas_top).offset(6);
        make.height.equalTo(@(20));
    }];
    
    
    [self addSubview:self.myCandleStickCombinedChartView];
    [self.myCandleStickCombinedChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.myBarCombinedChartView);
        make.top.equalTo(self);
        make.bottom.equalTo(self.myBarCombinedChartView.mas_top).offset(-20);
    }];
    
    [self addSubview:self.myCandleStickChartsViewLabel];
    [self.myCandleStickChartsViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(6);
        make.left.equalTo(self).offset(40);
        make.height.equalTo(@20);
    }];
}
- (void)setCandleAndBarNegativeDic:(NSDictionary *)candleAndBarNegativeDic{
    _candleAndBarNegativeDic = candleAndBarNegativeDic;
    self.candleArray = candleAndBarNegativeDic[@"arr"];
    
    self.chartslineExtArr = candleAndBarNegativeDic[@"lineExtArr"];
    self.chartsbaseLineArr = candleAndBarNegativeDic[@"baseLineArr"];
    self.parametsDic = candleAndBarNegativeDic[@"paramets"];

    QLChartsDataCategoryViewButtonType baseLineBtnType = [QLChartsDataCategoryView getQLChartsDataCategoryViewButtonTypeWithStr:[self.parametsDic objectForKey:@"baselinetype"]];
    QLChartsDataCategoryViewButtonType lineExtBtnType = [QLChartsDataCategoryView getQLChartsDataCategoryViewButtonTypeWithStr:[self.parametsDic objectForKey:@"linetype"]];
    NSMutableAttributedString *baseLineLabeltext = [QLChartsDataCategoryView getChartsViewLendStr:baseLineBtnType with:self.chartsbaseLineArr withBar:nil isLastObject:YES];
    NSMutableAttributedString *lineExtLabeltext = [QLChartsDataCategoryView getChartsViewLendStr:lineExtBtnType with:nil withBar:self.chartslineExtArr isLastObject:YES];
    self.myCandleStickChartsViewLabel.attributedText = baseLineLabeltext;
    self.myBarNegativeViewLabel.attributedText = lineExtLabeltext;

    
    QLWeakSelf;
    [self setChartsViewBlock:^(NSInteger index){
        PTTLog(@"index = %ld",(long)index);
        [weakSelf changeChartsLabelText:index];
    }];
}
- (void)changeChartsLabelText:(NSInteger)index{
    NSArray *baseLineArr = self.chartsbaseLineArr[index];
    QLChartsDataCategoryViewButtonType btnType = [QLChartsDataCategoryView getQLChartsDataCategoryViewButtonTypeWithStr:[self.parametsDic objectForKey:@"baselinetype"]];
    NSMutableAttributedString *baseLineLabeltext = [QLChartsDataCategoryView getChartsViewLendStr:btnType with:(NSMutableArray *)baseLineArr withBar:nil isLastObject:NO];
    
    NSArray *lineExtArr = self.chartslineExtArr[index];
    QLChartsDataCategoryViewButtonType lineExtBtnType = [QLChartsDataCategoryView getQLChartsDataCategoryViewButtonTypeWithStr:[self.parametsDic objectForKey:@"linetype"]];
    NSMutableAttributedString *lineExtLabeltext = [QLChartsDataCategoryView getChartsViewLendStr:lineExtBtnType with:nil withBar:(NSMutableArray *)lineExtArr isLastObject:NO];
    self.myCandleStickChartsViewLabel.attributedText = baseLineLabeltext;
    self.myBarNegativeViewLabel.attributedText = lineExtLabeltext;
    
}

- (UILabel *)myBarNegativeViewLabel{
    if (_myBarNegativeViewLabel == nil) {
        _myBarNegativeViewLabel = [[UILabel alloc]init];
        _myBarNegativeViewLabel.font = font_new_tabbar;
        _myBarNegativeViewLabel.text = @"123";
    }
    return _myBarNegativeViewLabel;
}
- (UILabel *)myCandleStickChartsViewLabel{
    if (_myCandleStickChartsViewLabel == nil) {
        _myCandleStickChartsViewLabel = [[UILabel alloc]init];
        _myCandleStickChartsViewLabel.font = font_new_tabbar;
        _myCandleStickChartsViewLabel.text = @"321";
    }
    return _myCandleStickChartsViewLabel;
}

- (void)setDataForBar{
    NSString *comePath = [[NSBundle mainBundle] pathForResource:@"Documentscome" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:comePath];
    NSArray *arr = [[dic objectForKey:@"item"]objectForKey:@"datas"];
    NSArray *lineExtArr = [[dic objectForKey:@"item"]objectForKey:@"lineExt"];
    NSArray *baseLineArr = [[dic objectForKey:@"item"]objectForKey:@"baseLine"];
    if ([arr count] > 0) {
        QLChartsCandleStickCombineTool *candleCombineTool = [[QLChartsCandleStickCombineTool alloc]init];
        QLChartsBarNegativeTool *barTool = [[QLChartsBarNegativeTool alloc]init];
        NSDictionary *dic = @{
                              @"period":@"6"
                              };
        NSString *period = @"6";
        BOOL isMinu = NO;
        if (period.integerValue>=1 && period.integerValue<=5) {
            isMinu = YES;
        }else{
            isMinu = NO;
        }
        //单纯的CandleStickChartView
        //[candleStickTool setupCandleStickChartsModel:(NSMutableArray *)arr withview:candleStickChartView withBool:isMinu];
        //混合的CandleStickChartView
        [candleCombineTool setupCandleStickChartsModel:(NSMutableArray *)arr withCombinedData:(NSMutableArray *)baseLineArr withview:self.myCandleStickCombinedChartView wihtParam:(NSMutableDictionary *)dic withBool:isMinu];
        [barTool setupBarNegativeChartsModel:(NSMutableArray *)lineExtArr withview:self.myBarCombinedChartView withParam:(NSMutableDictionary *)dic];
        
        NSDictionary *mDic = @{
                               @"arr":arr,
                               @"lineExtArr" : lineExtArr?lineExtArr:@[],
                               @"baseLineArr":baseLineArr?baseLineArr:@[],
                               @"paramets":dic
                               };
        self.candleAndBarNegativeDic = mDic;
        
    }
}

@end
