//
//  btn2ViewController.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/4/7.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "btn2ViewController.h"

#import "QLHJTimeShareAndBarChartsView.h"
@interface btn2ViewController ()

@end

@implementation btn2ViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color_background_f1f5f8;
    QLHJTimeShareAndBarChartsView *myView = [[QLHJTimeShareAndBarChartsView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
}

@end
