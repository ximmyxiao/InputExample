//
//  BasicInputViewController.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/9.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "BasicInputViewController.h"
#import "InputAccessoryView.h"

#define ACCESSORY_INPUT_BAR_HEIGHT (50)

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
    self.contentView .backgroundColor = [UIColor whiteColor];
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
    
    InputAccessoryView* accessoryView = [InputAccessoryView InputAccessoryViewInstance];
//    accessoryView.backgroundColor = [UIColor greenColor];
    accessoryView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:accessoryView];
    
    NSLayoutConstraint* accessoryBottomConstraint = [accessoryView.bottomAnchor constraintEqualToAnchor:_contentView.bottomAnchor constant:0];
    NSLayoutConstraint* accessoryLeadingConstraint = [accessoryView.leadingAnchor constraintEqualToAnchor:_contentView.leadingAnchor constant:0];
    NSLayoutConstraint* accessoryTrailingConstraint = [accessoryView.trailingAnchor constraintEqualToAnchor:_contentView.trailingAnchor constant:0];
    NSLayoutConstraint* accessoryHeightConstraint = [accessoryView.heightAnchor constraintGreaterThanOrEqualToConstant:ACCESSORY_INPUT_BAR_HEIGHT];
    [_contentView addConstraint:accessoryBottomConstraint];
    [_contentView addConstraint:accessoryLeadingConstraint];
    [_contentView addConstraint:accessoryTrailingConstraint];
    [accessoryView addConstraint:accessoryHeightConstraint];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
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

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)addKeyboardNotificationObserve
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangedFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

- (void)keyboardChangedFrame:(NSNotification*)notification
{
    float animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView beginAnimations:@"Animation" context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    self.contentBottomConstraint.constant = - ([UIScreen mainScreen].bounds.size.height - keyboardEndFrame.origin.y);
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
    
//    [UIView animateWithDuration:animationDuration animations:^{
//        self.contentBottomConstraint.constant = - ([UIScreen mainScreen].bounds.size.height - keyboardEndFrame.origin.y);
//        [self.view layoutIfNeeded];
//
//    }];
}
@end
