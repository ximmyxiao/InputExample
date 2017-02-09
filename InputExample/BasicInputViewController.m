//
//  BasicInputViewController.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/9.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "BasicInputViewController.h"
#import "InputAccessoryView.h"


@interface BasicInputViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView* contentView;
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) InputAccessoryView* inputAccesoryView;
@property(nonatomic,strong) NSLayoutConstraint* contentBottomConstraint;
@end

@implementation BasicInputViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)contructContent
{
    self.contentView = [UIView new];
    self.contentView .backgroundColor = [UIColor blueColor];
    self.contentView .translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.contentView ];
    
    NSLayoutConstraint* topConstraint = [self.contentView .topAnchor constraintEqualToAnchor:self.view.topAnchor];
    self.contentBottomConstraint = [self.contentView .bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0];
    NSLayoutConstraint* leadingConstraint = [self.contentView .leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0];
    NSLayoutConstraint* tailingConstraint = [self.contentView .trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0];
    [self.view addConstraint:topConstraint];
    [self.view addConstraint:self.contentBottomConstraint];
    [self.view addConstraint:leadingConstraint];
    [self.view addConstraint:tailingConstraint];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self contructContent];
    [self addKeyboardNotificationObserve];
    
    
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


- (void)addKeyboardNotificationObserve
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangedFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardChangedFrame:(NSNotification*)notification
{
    
}
@end
