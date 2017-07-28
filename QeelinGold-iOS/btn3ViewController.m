//
//  btn3ViewController.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/7/28.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "btn3ViewController.h"
#import "QLHJCandleAndBarChartsView.h"
@interface btn3ViewController ()

@end

@implementation btn3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color_background_f1f5f8;
    QLHJCandleAndBarChartsView *myView = [[QLHJCandleAndBarChartsView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
