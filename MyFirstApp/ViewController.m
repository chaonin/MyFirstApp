//
//  ViewController.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/10.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    //+号开头类方法
    //-号开头实例方法
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIColor *gray = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.view.backgroundColor = gray;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.2 green:0.72 blue:0.46 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    titleLabel.text = @"2016年7月10号";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
