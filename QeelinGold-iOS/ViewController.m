//
//  ViewController.m
//  QeelinGold-iOS
//
//  Created by MacBook on 2017/4/5.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "ViewController.h"
#import "btn1ViewController.h"
#import "btn2ViewController.h"
#import "btn3ViewController.h"
#import "UIButton+Action.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()
@property (nonatomic ,strong)UIButton *button1 ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
//    NSDictionary *dic =@{
//                         @"page":@"1",
//                         @"limit":@"10"
//                         };
//    NSString *u = @"";
//    NSString *url = [NSString stringWithFormat:@"%@%@",DEF_GetHomepage,u];
//    [CWNetworkManager getRequstWithURL:url params:dic successBlock:^(NSDictionary *returnData) {
//        PTTLog(@"returnData = %@",returnData);
//    } failureBlock:^(NSError *error) {
//        PTTLog(@"error = %@",error);
//    } showHUD:NO];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 200, 100, 40);
    btn1.backgroundColor = [UIColor  blackColor];
    [btn1 setTitle:@"图表1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(10, 250, 100, 40);
    [btn2 setTitle:@"图表2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame)+ 20, 250, 100, 40);
    [btn3 setTitle:@"图表2" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor blackColor];
    [btn3 addTarget:self action:@selector(btn3click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];

    
    //第一个按钮
    UIButton *button1 = [UIButton createBtnWithFrame:CGRectMake(10, 300, 100, 50) title:@"按钮" actionBlock:^(UIButton *button) {
        float r = random()%255/255.0;
        float g = random()%255/255.0;
        float b = random()%255/255.0;
        self.view.backgroundColor = [UIColor blueColor];
        PTTLog(@"hhhhhh");
    }];
    self.button1 = button1;
    button1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button1];
    button1.myCode = @"chenweidada";
    NSLog(@"myCode = %@",button1.myCode);
    NSString *str = [button1 chenweidada];
    NSLog(@"str = %@",str);
    Method  oriMethod = class_getInstanceMethod([UIButton class], @selector(chenweidada));
    Method  newMethod = class_getInstanceMethod([self class], @selector(newchenweidada));
    method_exchangeImplementations(oriMethod, newMethod);
    NSString *newstr = [button1 chenweidada];
    NSLog(@"newstr = %@",newstr);
    //第二个按钮
    UIButton *button2 = [UIButton createBtnWithFrame:CGRectMake(10, CGRectGetMaxY(button1.frame) + 50, 100, 50) title:@"按钮2" actionBlock:nil];
    button2.actionBlock = ^(UIButton *button){
        NSLog(@"---%@---",button.currentTitle);
    };
    button2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button2];
    
    ((void (*)(id,SEL)) objc_msgSend)(button1,@selector(sendMyMethod));
    
    class_addMethod([UIButton class], @selector(onlyDeclareMethod: andWithSec:), (IMP)implementOnlyDeclare, "@@:@@");
    
    [button1 onlyDeclareMethod:@"chenwei" andWithSec:@"hehe"];
}
NSString *implementOnlyDeclare(id class ,SEL sel,NSString * first,NSString * second)
{
    NSLog(@"%@",[NSString stringWithFormat:@"在resolveInstanceMethod中通过addMethod方法实现方法:%@+%@",first,second]);
    return [NSString stringWithFormat:@"在resolveInstanceMethod中通过addMethod方法实现方法:%@+%@",first,second];
}

- (NSString *)newchenweidada{
    return @"newchenweidada";
}
- (void)btn1click{
    btn1ViewController *vc = [[btn1ViewController alloc]init];
    vc.btn = self.button1;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btn2click{
    btn2ViewController *vc = [[btn2ViewController alloc  ]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btn3click{
    btn3ViewController *vc = [[btn3ViewController alloc  ]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
