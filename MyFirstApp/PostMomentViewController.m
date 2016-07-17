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

@end

@implementation PostMomentViewController

-(void)saveMoment{
    
    NSString *content = self.inputView.text;
    NSNumber *timestamp = [KetangUtility timestamp];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:content, @"content", timestamp, @"timestamp", nil];
    BOOL saveSuccess = [KetangPersistentManager saveDictionary:dictionary];
    if (saveSuccess){
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSNotification *notification = [NSNotification notificationWithName:@"newMomentSave" object:nil];
        //通知去刷新
        [center postNotification:notification];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                               UIBarButtonSystemItemDone target:self action:@selector(saveMoment)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                               UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = finish;
    self.navigationItem.leftBarButtonItem = cancel;
    
    //初始化笔记编辑框
    self.inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, 300)];
    self.inputView.editable = YES;
    [self.view addSubview:self.inputView];
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
