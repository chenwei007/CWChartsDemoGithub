//
//  btn1ViewController.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/4/7.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "btn1ViewController.h"
#import "UIButton+Action.h"
#import "QLHJTimeShareChartsView.h"
@interface btn1ViewController ()
@end

@implementation btn1ViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)setBtn:(UIButton *)btn{
    NSString *newstr = [btn chenweidada];
    NSLog(@"新页面newstr = %@",newstr);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color_background_f1f5f8;

    QLHJTimeShareChartsView *timeChatsView = [[QLHJTimeShareChartsView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:timeChatsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
