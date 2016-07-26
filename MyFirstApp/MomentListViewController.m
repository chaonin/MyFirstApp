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
#import "PostMomentViewController.h"
#import "KetangPersistentManager.h"
#import "KetangUtility.h"
#import "BlankView.h"
#import "RetryView.h"

@interface MomentListViewController ()

@property(nonatomic, strong) NSArray *moment;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *blankView;
@property(nonatomic, strong) UIView *retryView;
@property(nonatomic) BOOL tableShowed;

@end

@implementation MomentListViewController

-(void)viewWillAppear:(BOOL)animated{
    
    if(self.tableView != nil){
        //找到被选中的那一行
        NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
        if (selectedRow != nil) {
            //取消这一行的选中状态
            [self.tableView deselectRowAtIndexPath:selectedRow animated:YES];
        }
        
    }
}

-(void)handleView{
    
    [self hideLoading];

    //如果读取失败，展示retryView
    if (self.moment == nil) {
        [self.tableView removeFromSuperview];
        [self.blankView removeFromSuperview];
        [self.retryView removeFromSuperview];
        [self.view addSubview:self.retryView];
        self.tableShowed = NO;
        return;
    }
    //如果读取成功，但条目数为0，展示blankView
    if([self.moment count] == 0){
        [self.tableView removeFromSuperview];
        [self.blankView removeFromSuperview];
        [self.retryView removeFromSuperview];
        [self.view addSubview:self.blankView];
        self.tableShowed = NO;
        return;
    }
    
    //动画处理新插入的笔记
    if (self.tableShowed) {
        [self.tableView beginUpdates];
        NSIndexPath *theRow = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *insertRows = [NSArray arrayWithObject:theRow];
        [self.tableView insertRowsAtIndexPaths:insertRows withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        return;
    }
    
    //如果读取成功，但条目数不为0，则展示tableView
    [self.tableView removeFromSuperview];
    [self.blankView removeFromSuperview];
    [self.retryView removeFromSuperview];
    [self.view addSubview:self.tableView];
    self.tableShowed = YES;
    //[self.tableView reloadData];//前面的动画模块已经载入笔记

}

-(void)loadMoment{
    
    [self showLoading];
    
    //7/23: display the moment sorted
    NSMutableArray *momentBeforeSorting = [KetangPersistentManager getMoment];
    self.moment = [momentBeforeSorting sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        NSNumber *aTimestamp = [a objectForKey:@"timestamp"];
        NSNumber *bTitmestamp = [b objectForKey:@"timestamp"];
        //如果a更新，a排在b之前
        if(aTimestamp > bTitmestamp){
            return (NSComparisonResult)NSOrderedAscending;
        } else if(aTimestamp < bTitmestamp)
            //如果b更新，b排在a之前
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        //如果相同，顺序不变
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    //self.moment = [KetangPersistentManager getMoment];
    [self performSelector:@selector(handleView) withObject:nil afterDelay:0.5];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableShowed = NO;
    
    // Do any additional setup after loading the view.
    //1、表格的实例化和初始化
    // 64 = 导航栏高度＋状态栏高度
    // CGRectMake(左上角x座标，左上角Y座标, 块大小宽度，块大小高度）
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,[KetangUtility screenWidth], [KetangUtility screenHeight]-64)];
    [self.view addSubview:self.tableView];
    //协议签署
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //2、空台提示页实例化和初始化
    self.blankView = [BlankView blankViewWithText:@"空空如也" buttonText:@"写一条" target:self action:@selector(post)];
    
    //3、重试提示页实例化和初始化
    self.retryView = [RetryView retryViewWithText:@"额...出错了" buttonText:@"重试" target:self action:@selector(loadMoment)];

    
    //写笔记按钮: target点击调用后面action对应函数的类 action调用的函数
    UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem = post;
   
    
    [self setSingleLineTitle:@"笔记"];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loadMoment) name:@"newMomentSave" object:nil];
    //self.moment = [KetangPersistentManager getMoment];
    //self.moment = momentBeforeSorting;
    //7/23: use recontructed sort-moment code
    [self loadMoment];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //根据笔记的条数来返回需要显示的表格行数
    if (self.moment == nil){
        return 0;
    }
    return [self.moment count];
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
    
    /*NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"15", @"day",
                                @"星期五",@"dayOfWeek",
                                @"2016年7月", @"yearAndMonth",
                                @"向狂想者致敬",@"content", nil];*/
    
    NSInteger row = indexPath.row;
    
    //NSDictionary *dictionary = self.moment[0];
    //动态显示各行的值
    NSDictionary *dictionary = self.moment[row];
    
    NSNumber *timestamp = [dictionary objectForKey:@"timestamp"];
    NSMutableDictionary *dateDictionary = [KetangUtility dateThen:timestamp];
    NSString *year = [dateDictionary objectForKey:@"year"];
    NSString *month = [dateDictionary objectForKey:@"month"];
    NSString *yearAndMonth = [NSString stringWithFormat:@"%@年%@月", year, month];
    [dateDictionary setObject:yearAndMonth forKey:@"yearAndMonth"];
    
    [dateDictionary addEntriesFromDictionary:dictionary];
    
    //[cell setContentWithDictionary:dictionary];
    [cell setContentWithDictionary:dateDictionary];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSDictionary *dictionary = self.moment[row];
    NSString *content = [dictionary objectForKey:@"content"];

    CGFloat height = [MomentCell cellHeightFromText:content];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSDictionary *dictionary = self.moment[row];
    
    
    NSNumber *timestamp = [dictionary objectForKey:@"timestamp"];
    NSMutableDictionary *dateDictionary = [KetangUtility dateThen:timestamp];
    NSString *year = [dateDictionary objectForKey:@"year"];
    NSString *month = [dateDictionary objectForKey:@"month"];
    NSString *day = [dateDictionary objectForKey:@"day"];
    NSString *yearAndMonthAndDay = [NSString stringWithFormat:@"%@年%@月%@日", year, month, day];
    [dateDictionary setObject:yearAndMonthAndDay forKey:@"yearAndMonthAndDay"];
    
    [dateDictionary addEntriesFromDictionary:dictionary];
    
    
    /*
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"2016年7月", @"yearAndMonth",
                                                                          @"向狂想者致敬",@"content", nil];
    
    MomentDetailViewController *detail = [[MomentDetailViewController alloc] initWithDictionary:dictionary];*/
    
    MomentDetailViewController *detail = [[MomentDetailViewController alloc] initWithDictionary:dateDictionary];

    //右侧滑入笔记详情
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)post{
    
    PostMomentViewController *post = [[PostMomentViewController alloc] init];
    
    //把post挂到 导航栏 下
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:post];
    
    
    //导航栏挂到主导航栏
    //底部升起 presentViewController
    //右侧滑入 pushViewController
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
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
