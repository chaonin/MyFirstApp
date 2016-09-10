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
#import "PostMomentViewController.h"


@interface MomentDetailViewController ()

@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,strong) NSNotificationCenter *center;
@property (nonatomic,strong) UILabel *contentText;


@end

@implementation MomentDetailViewController

-(void)removeMoment{
    NSInteger count, i;
    
    id array = [KetangPersistentManager getMoment];
    NSMutableArray *mmoment = [NSMutableArray arrayWithArray:array];
    count = mmoment.count;
    for (i = 0; i < count; i = i+1){
        if ([[mmoment[i] objectForKey:@"timestamp"]  isEqual:[self.dictionary objectForKey:@"timestamp"]] ) {
            //[self showAlertWithTitle:@"fff" message:nil buttonText:@"好"];

            [mmoment removeObjectAtIndex:i];
            BOOL saveSuccess = [KetangPersistentManager saveMoment:mmoment];
            if (saveSuccess) {
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                NSNotification *notification = [NSNotification notificationWithName:@"deleteReload" object:nil];
                //通知去刷新
                [center postNotification:notification];
                //回到笔记列表
                [self.navigationController popViewControllerAnimated:YES];

                //[NSThread sleepForTimeInterval:3];

                return;
            }
            [self showAlertWithTitle:@"删除笔记失败" message:nil buttonText:@"好"];
            return;
        }
    }
}

-(void)editMoment{

    PostMomentViewController *edit = [[PostMomentViewController alloc] initWithDictionary:self.dictionary];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:edit];
    
    //导航栏挂到主导航栏
    //底部升起 presentViewController
    //右侧滑入 pushViewController
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //显示工具栏
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    //UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *remove = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeMoment)];
    //用Compose按钮代替Edit
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editMoment)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    //[self.navigationController.toolbar setItems:[NSArray arrayWithObjects:item1,flexible,nil] animated:YES];
    [self setToolbarItems:[NSArray arrayWithObjects:remove,flexible,edit,flexible,nil] animated:YES];
    
    //设置工具栏背景
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:0.2 green:0.72 blue:0.46 alpha:1];
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.tintColor = [UIColor whiteColor];
    
}

-(void)refreshContent{
    //获取重新编辑后的内容更新显示，并更新dictionary
    NSArray *array = [KetangPersistentManager getMoment];
    NSInteger count = array.count;
    NSString *newContent = [array[count-1] objectForKey:@"content"];
    NSNumber *timestamp = [array[count-1] objectForKey:@"timestamp"];
    //更新显示
    self.contentText.text = newContent;
    //更新笔记内容和时间戳
    [self.dictionary setValue:newContent forKey:@"content"];
    [self.dictionary setValue:timestamp forKey:@"timestamp"];
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
    self.contentText = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, [KetangUtility screenWidth]-20-20,contentRect.size.height)];

    self.contentText.numberOfLines = 0;//显示多行
    self.contentText.text = content;
    self.contentText.textColor = [UIColor blackColor];
    self.contentText.font = [UIFont systemFontOfSize:18];
    self.contentText.textAlignment = NSTextAlignmentLeft;
    //[self.view addSubview:contentText];//text放进scrollView，这里不再需要
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [KetangUtility screenWidth], [KetangUtility screenHeight]-64)];
    scroll.contentSize = CGSizeMake(contentRect.size.width, contentRect.size.height+20+20);//上下留白20，滑动有余地，不会那么局促
    [scroll addSubview:self.contentText];
    [self.view addSubview:scroll];
    
    //当笔记被重新笔记后，通过editReload消息刷新显示
    [self.center addObserver:self selector:@selector(refreshContent) name:@"editReload" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MomentDetailViewController *)initWithDictionary:(NSDictionary *)dictionary andNotificationCenter:(NSNotificationCenter *) center{
    
    self = [super init];
    self.dictionary = dictionary;
    self.center = center;
    
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
