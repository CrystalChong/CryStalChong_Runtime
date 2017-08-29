//
//  ViewController.m
//  TEST_RUNtime
//
//  Created by ZhengZheng Li on 2017/8/29.
//  Copyright © 2017年 CrystalChongZhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建视图
    [self _creatSubViews];

}
- (void)_creatSubViews{
    //按钮
    UIButton *bvtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    bvtn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [bvtn setTitle:@"点击" forState:UIControlStateNormal];
    [bvtn addTarget:self action:@selector(_cratBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self _addStyle:bvtn];
    [self.view addSubview:bvtn];
}
//添加样式
- (void)_addStyle:(UIView *)view{
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
}

//DEMO
- (void)_cratBtnAction{
    NSMutableArray *arry = [NSMutableArray array];
    [arry addObject:@"test"];
    /*
     //==========数组越界======
    NSMutableArray *arry = [NSMutableArray array];
    
    [arry objectAtIndex:1000];

    //==========添加空元素=======
    
    NSString *str = nil;
    [arry addObject:str];
    
    
    //移除空元素
    [arry removeObject:nil];
    
    NSLog(@"-----+%s",__func__);
    NSLog(@"-----+%s",__FUNCTION__);
    //移除越界元素
    [arry removeObjectAtIndex:1000];
    */
    
    NSString *str = nil;
    NSDictionary *dic =@{
                         @"key":str
                         };
    
    NSLog(@"%@",dic);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
