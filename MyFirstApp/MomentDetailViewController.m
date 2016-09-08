//
//  MomentDetailViewController.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/14.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "MomentDetailViewController.h"
#import "KetangUtility.h"
#import "KetangPersistentManager.h"

@interface MomentDetailViewController ()

@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,strong) NSArray *moment;

@end

@implementation MomentDetailViewController

-(void)handler1{
    [self showAlertWithTitle:@"Haha" message:nil buttonText:@"ok"];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    //UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(handler1)];
    
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //[self.navigationController.toolbar setItems:[NSArray arrayWithObjects:item1,flexible,item2,flexible,item3,flexible,item4,flexible,item5,flexible,nil] animated:YES];
    [self setToolbarItems:[NSArray arrayWithObjects:item1,flexible,nil] animated:YES];
    
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:0.2 green:0.72 blue:0.46 alpha:1];
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.tintColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackButton];
    
    // Do any additional setup after loading the view.
    //+号开头类方法
    //-号开头实例方法
    
    /*
    NSString *yearAndMonth = [self.dictionary objectForKey:@"yearAndMonth"];
    NSString *content = [self.dictionary objectForKey:@"content"];
    [self setSingleLineTitle:yearAndMonth];*/
    NSString *yearAndMonthAndDay = [self.dictionary objectForKey:@"yearAndMonthAndDay"];
    NSString *content = [self.dictionary objectForKey:@"content"];
    [self setSingleLineTitle:yearAndMonthAndDay];
    
    
    //获取正文文字高度
    CGSize contentSize = CGSizeMake([KetangUtility screenWidth]-40, 999999999999);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    
    CGRect contentRect = [content boundingRectWithSize:contentSize
                                               options:NSStringDrawingTruncatesLastVisibleLine|
                                                       NSStringDrawingUsesLineFragmentOrigin|
                                                       NSStringDrawingUsesFontLeading
                                            attributes:attributes
                                               context:nil];
    //正文文字
    //UILabel *contentText = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, [UIScreen mainScreen].bounds.size.width-20-20, 20)];
    //使用实际高度
    //UILabel *contentText = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, [KetangUtility screenWidth]-20-20,contentRect.size.height)];
    // label将会放进ScrollView，84是相对于屏幕的顶端坐标（40+24+20），放进ScroView后，相对于ScroView将变为20
    UILabel *contentText = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, [KetangUtility screenWidth]-20-20,contentRect.size.height)];

    contentText.numberOfLines = 0;//显示多行
    contentText.text = content;
    contentText.textColor = [UIColor blackColor];
    contentText.font = [UIFont systemFontOfSize:15];
    contentText.textAlignment = NSTextAlignmentLeft;
    //[self.view addSubview:contentText];//text放进scrollView，这里不再需要
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [KetangUtility screenWidth], [KetangUtility screenHeight]-64)];
    scroll.contentSize = CGSizeMake(contentRect.size.width, contentRect.size.height+20+20);//上下留白20，滑动有余地，不会那么局促
    [scroll addSubview:contentText];
    [self.view addSubview:scroll];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MomentDetailViewController *)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    self.dictionary = dictionary;
    
    return self;
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
