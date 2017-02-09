//
//  BasicInputViewController.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/9.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "BasicInputViewController.h"
#import "InputAccessoryView.h"


@interface BasicInputViewController ()
@property(nonatomic,strong) InputAccessoryView* inputAccesoryView;
@end

@implementation BasicInputViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
