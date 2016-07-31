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
#import "UIImage+Ketang.h"

@interface MomentListViewController ()

@property(nonatomic, strong) NSArray *moment;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *blankView;
@property(nonatomic, strong) UIView *retryView;
@property(nonatomic) BOOL tableShowed;
@property(nonatomic, strong) UIImageView *cover;

@end

@implementation MomentListViewController

-(void)showCover{
    //设定好封面图片
    self.cover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [KetangUtility screenWidth], [KetangUtility screenHeight])];
    self.cover.image = [UIImage imageNamed:@"cover"];
    self.cover.userInteractionEnabled = YES;
    self.cover.contentMode = UIViewContentModeScaleAspectFill;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.cover];
    
    //设定好好封面图片上按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(([KetangUtility screenWidth]-200)/2, [KetangUtility screenHeight]-84, 200, 44)];
    [button setTitle:@"进入"
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];
    
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:0.3] andSize:button.frame.size]
                      forState:UIControlStateHighlighted];
    [self.cover addSubview:button];
    
    [button addTarget:self
               action:@selector(hideCover)
     forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)hideCover{
    
    //隐藏封面
    [self.cover removeFromSuperview];
    
    //载入笔记
    [self loadMoment];
}


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
    [self.tableView reloadData];//前面的动画模块已经载入笔记

}

-(void)loadMoment{
    
    [self showLoading];
    
    //7/23: display the moment sorted
    NSMutableArray *momentBeforeSorting = [KetangPersistentManager getMoment];
    self.moment = [momentBeforeSorting sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a,NSDictionary*b) {
        
        NSNumber *aTimestamp = [a objectForKey:@"timestamp"];
        NSNumber *bTimestamp = [b objectForKey:@"timestamp"];
        
        //如果A更新，A排在B之前
        if (aTimestamp > bTimestamp) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        //如果B更新，B排在A之前
        
        if (bTimestamp > aTimestamp) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        //如果一样，则顺序不改变
        return (NSComparisonResult)NSOrderedSame;
    }];

    //self.moment = [KetangPersistentManager getMoment];
    [self performSelector:@selector(handleView) withObject:nil afterDelay:0.5];
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCover];
    
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
    
    //2、空白提示页实例化和初始化
    self.blankView = [BlankView blankViewWithText:@"空空如也" buttonText:@"写一条" target:self action:@selector(post)];
    
    //3、重试提示页实例化和初始化
    self.retryView = [RetryView retryViewWithText:@"额...出错了" buttonText:@"重试" target:self action:@selector(loadMoment)];

    
    //写笔记按钮: target点击调用后面action对应函数的类 action调用的函数
    //UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(post)];
    //self.navigationItem.rightBarButtonItem = post;
    [self setRightNavigationButtonWithTitle:@"写笔记" target:self action:@selector(post)];
    
    [self setSingleLineTitle:@"笔记"];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loadMoment) name:@"newMomentSave" object:nil];
    //[self showAlertWithTitle:@"here2" message:nil buttonText:@"知道了"];

    //[self showCover];

    //self.moment = [KetangPersistentManager getMoment];
    //self.moment = momentBeforeSorting;
    //7/23: use recontructed sort-moment code
    //[self loadMoment];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
