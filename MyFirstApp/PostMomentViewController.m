//
//  PostMomentViewController.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/16.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "PostMomentViewController.h"
#import "KetangUtility.h"
#import "KetangPersistentManager.h"

@interface PostMomentViewController ()

@property (nonatomic, strong) UITextView *inputView;
@property (nonatomic, strong) NSString *text;//被初始化为0
@property NSInteger isEdit;//被初始化为0
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation PostMomentViewController


//该初始化方法再编辑按钮点击后被调用
-(PostMomentViewController *)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    self.dictionary = dictionary;
    self.text = [self.dictionary objectForKey:@"content"];
    self.isEdit = 1;
    return self;
}

-(void)saveWithEdit{
    //如果没有写任何内容，不让存储，且不要给用户提示
    if (self.inputView.text.length == 0) {
        return;
    }
    
    //如果用户输入的内容超过2000字，提示超过存储范围
    if (self.inputView.text.length > 2000) {
        [self showAlertWithTitle:@"文字内容超过2000，无法存储" message:nil buttonText:@"知道了"];
        return;
    }
    
    //展示阻塞加载
    [self showModaLoading];
    
    //获取重新编辑后的内容
    NSString *content = self.inputView.text;
    NSNumber *timestamp = [KetangUtility timestamp];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content, @"content", timestamp, @"timestamp", nil];
    
    //读取笔记，把正在编辑的笔记从后台删除（读取、查询、删除并保存）->这个可以发送一个"deleteReload"通知给MomentListViewController做好刷新显示
                                                           //而不是"newMomentSave"通知，否则出错!（与delete笔记后重新显示的逻辑相同）
    id array = [KetangPersistentManager getMoment];
    NSMutableArray *moment = [NSMutableArray arrayWithArray:array];
    NSInteger count = moment.count,i;
    BOOL saveSuccess = false;
    for (i = 0; i < count; i = i+1){
        if ([[moment[i] objectForKey:@"timestamp"]  isEqual:[self.dictionary objectForKey:@"timestamp"]] ) {
            [moment removeObjectAtIndex:i];
            saveSuccess = [KetangPersistentManager saveMoment:moment];
            if (saveSuccess) {
                break;
            }
            [self showAlertWithTitle:@"存储失败" message:nil buttonText:@"好"];
            return;
        }
    }

    //保存重新编辑后的笔记
    saveSuccess = [KetangPersistentManager saveDictionary:dictionary];
    //移除阻塞加载
    [self hideModaLoading];
    if (saveSuccess){
        
        //通知MomentListViewController去刷新
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSNotification *notification = [NSNotification notificationWithName:@"deleteReload" object:nil];
        [center postNotification:notification];
        
        //通知MomentDetailViewController去刷新
        notification = [NSNotification notificationWithName:@"editReload" object:nil];
        [center postNotification:notification];
        
        //释放编辑视图
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return;
    }
    [self showAlertWithTitle:@"存储失败" message:nil buttonText:@"好"];
}


-(void)saveMoment{
    
    //如果笔记是重新被编辑，调用另一个方法存储笔记，以覆盖原笔记
    if (self.isEdit) {
        [self saveWithEdit];
        return;
    }
    
    //如果没有写任何内容，不让存储，且不要给用户提示
    if (self.inputView.text.length == 0) {
        return;
    }
    
    //如果用户输入的内容超过2000字，提示超过存储范围
    if (self.inputView.text.length > 2000) {
        [self showAlertWithTitle:@"文字内容超过2000，无法存储" message:nil buttonText:@"知道了"];
        return;
    }
    
    //展示阻塞加载
    [self showModaLoading];
    
    NSString *content = self.inputView.text;
    NSNumber *timestamp = [KetangUtility timestamp];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content, @"content", timestamp, @"timestamp", nil];
    BOOL saveSuccess = [KetangPersistentManager saveDictionary:dictionary];
    //移除阻塞加载
    [self hideModaLoading];
    
    if (saveSuccess){
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSNotification *notification = [NSNotification notificationWithName:@"newMomentSave" object:nil];
        //通知去刷新
        [center postNotification:notification];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self showAlertWithTitle:@"存储失败" message:nil buttonText:@"好"];
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.inputView.delegate = self;

    // Do any additional setup after loading the view.
    
    //笔记标题
    [self setSingleLineTitle:@"写笔记"];
    
    //笔记保存和取消按钮
    [self setRightNavigationButtonWithTitle:@"保存" target:self action:@selector(saveMoment)];
    [self setLeftNavigationButtonWithTitle:@"取消" target:self action:@selector(cancel)];
    
    //初始化笔记编辑框
    self.inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, 300)];
    self.inputView.font = [UIFont systemFontOfSize:18];
    //self.inputView.editable = YES;
    [self.view addSubview:self.inputView];
    self.inputView.text = self.text;//self.text为该类的全局变量，声明的时候默认初始化为0，
                                    //所以不用担心是创建笔记时未初始化text（编辑时候调用initWithDictionary初始化该类并初始化text为笔记内容）
    [self.inputView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

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
