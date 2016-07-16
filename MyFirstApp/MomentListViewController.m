//
//  MomentListViewController.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/14.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "MomentListViewController.h"
#import "MomentCell.h"
#import "MomentDetailViewController.h"

@interface MomentListViewController ()

@end

@implementation MomentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 64 = 导航栏高度＋状态栏高度
    // CGRectMake(左上角x座标，左上角Y座标, 块大小宽度，块大小高度）
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:tableView];
    //协议签署
    tableView.dataSource = self;
    tableView.delegate = self;
   
    //自动调整可滚动视图显示设置为NO（将变为上对齐）
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setSingleLineTitle:@"笔记"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moment"];
    
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moment"];
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 47, 46)];
        dayLabel.text = @"15";
        dayLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
        dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
        dayLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:dayLabel];
        
        UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 23, 36, 15)];
        dayOfWeekLabel.text = @"星期五";
        dayOfWeekLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
        dayOfWeekLabel.font = [UIFont systemFontOfSize:12];
        dayOfWeekLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:dayOfWeekLabel];
        
        UILabel *yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 38, 60, 15)];
        yearAndMonthLabel.text = @"2016年7月";
        yearAndMonthLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
        yearAndMonthLabel.font = [UIFont systemFontOfSize:12];
        yearAndMonthLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:yearAndMonthLabel];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-240)/2, 79, 240, 42)];
        contentLabel.text = @"向狂想者致敬";
        contentLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:contentLabel];
        
        
    }*/
    
    MomentCell *cell = [MomentCell prepareCellForTableView:tableView];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"15", @"day",
                                @"星期五",@"dayOfWeek",
                                @"2016年7月", @"yearAndMonth",
                                @"向狂想者致敬",@"content", nil];
    [cell setContentWithDictionary:dictionary];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MomentDetailViewController *detail = [[MomentDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
    
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
