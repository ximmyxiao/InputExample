//
//  BasicInputViewController.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/9.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "BasicInputViewController.h"
#import "InputAccessoryView.h"

typedef NS_ENUM(NSInteger,INPUT_KEYBOARD_TYPE) {
    
    INPUT_KEYBOARD_TYPE_NONE = 0,
    INPUT_KEYBOARD_TYPE_KEYBOARD,
    INPUT_KEYBOARD_TYPE_PANEL,
};

#define ACCESSORY_INPUT_BAR_HEIGHT (50)
#define PANEL_HEIGHT (223)
@interface BasicInputViewController ()<InputAccessoryViewDelegate, UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView* contentView;
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) InputAccessoryView* inputAccesoryView;
@property(nonatomic,strong) NSLayoutConstraint* contentBottomConstraint;
@property(nonatomic,strong) NSLayoutConstraint* panelHeightConstraint;
@property(nonatomic,strong) UIView* operationPanel;
@property(nonatomic,assign) INPUT_KEYBOARD_TYPE inputType;
@property(nonatomic,assign) CGRect keyboardFrame;
@property(nonatomic,assign) UIViewAnimationCurve animationCurve;
@property(nonatomic,assign) float animationDuration;
@end

@implementation BasicInputViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetConstraints
{
        [UIView beginAnimations:@"Animation" context:NULL];
        [UIView setAnimationCurve:self.animationCurve];
        [UIView setAnimationDuration:self.animationDuration];
        switch (_inputType) {
            case INPUT_KEYBOARD_TYPE_NONE:
                self.panelHeightConstraint.constant = 0;
                self.contentBottomConstraint.constant = 0;
                break;
            case INPUT_KEYBOARD_TYPE_KEYBOARD:
//                self.panelHeightConstraint.constant = 0;
//                self.contentBottomConstraint.constant = - ([UIScreen mainScreen].bounds.size.height - self.keyboardFrame.origin.y);
                [self.inputAccesoryView keyboardIsShow];
                break;
            case INPUT_KEYBOARD_TYPE_PANEL:
                self.panelHeightConstraint.constant = PANEL_HEIGHT;
                self.contentBottomConstraint.constant = 0;
                break;
            default:
                break;
        }
        [self.view layoutIfNeeded];
        [UIView commitAnimations];
    
    [UIView animateWithDuration:0.3 animations:^{


    }];
}

- (void)setInputType:(INPUT_KEYBOARD_TYPE)inputType
{
    _inputType = inputType;
    [self resetConstraints];
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
    
    self.inputAccesoryView = [InputAccessoryView InputAccessoryViewInstance];
    self.inputAccesoryView.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputAccesoryView.delegate = self;
    [self.contentView addSubview:self.inputAccesoryView];
    
    self.operationPanel = [UIView new];
    self.operationPanel.backgroundColor = [UIColor yellowColor];//HEXCOLOR(0xf3f4f6);
    self.operationPanel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_contentView addSubview:self.operationPanel];
    
    
    NSLayoutConstraint* accessoryBottomConstraint = [self.inputAccesoryView.bottomAnchor constraintEqualToAnchor:self.operationPanel.topAnchor constant:0];
    NSLayoutConstraint* accessoryLeadingConstraint = [self.inputAccesoryView.leadingAnchor constraintEqualToAnchor:_contentView.leadingAnchor constant:0];
    NSLayoutConstraint* accessoryTrailingConstraint = [self.inputAccesoryView.trailingAnchor constraintEqualToAnchor:_contentView.trailingAnchor constant:0];
    NSLayoutConstraint* accessoryHeightConstraint = [self.inputAccesoryView.heightAnchor constraintGreaterThanOrEqualToConstant:ACCESSORY_INPUT_BAR_HEIGHT];
    [_contentView addConstraint:accessoryBottomConstraint];
    [_contentView addConstraint:accessoryLeadingConstraint];
    [_contentView addConstraint:accessoryTrailingConstraint];
    [self.inputAccesoryView addConstraint:accessoryHeightConstraint];
    

    
    NSLayoutConstraint* panelBottomConstraint = [self.operationPanel.bottomAnchor constraintEqualToAnchor:_contentView.bottomAnchor constant:0];
    NSLayoutConstraint* panelLeadingConstraint = [self.operationPanel.leadingAnchor constraintEqualToAnchor:_contentView.leadingAnchor constant:0];
    NSLayoutConstraint* panelTrailingConstraint = [self.operationPanel.trailingAnchor constraintEqualToAnchor:_contentView.trailingAnchor constant:0];
    self.panelHeightConstraint = [self.operationPanel.heightAnchor constraintGreaterThanOrEqualToConstant:0];
    [_contentView addConstraint:panelBottomConstraint];
    [_contentView addConstraint:panelLeadingConstraint];
    [_contentView addConstraint:panelTrailingConstraint];
    [self.operationPanel addConstraint: self.panelHeightConstraint];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self contructContent];
    [self addKeyboardNotificationObserve];
    
    self.animationCurve = 7;
    self.animationDuration = 0.25;
    
    
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
    NSLog(@"vc touchesEnded");

    self.inputType = INPUT_KEYBOARD_TYPE_NONE;
    [self.view endEditing:YES];
}

- (void)addKeyboardNotificationObserve
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    
    
}

- (void)keyboardWillChangeFrame:(NSNotification*)notification
{
    self.animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    self.keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView beginAnimations:@"Animation" context:NULL];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationDuration:self.animationDuration];
    self.panelHeightConstraint.constant = 0;
    self.contentBottomConstraint.constant = - ([UIScreen mainScreen].bounds.size.height - self.keyboardFrame.origin.y);    [self.view layoutIfNeeded];
    [UIView commitAnimations];
    if (self.keyboardFrame.origin.y < [[UIScreen mainScreen] bounds].size.height)
    {
        self.inputType = INPUT_KEYBOARD_TYPE_KEYBOARD;
    }
//    [UIView animateWithDuration:animationDuration animations:^{
//        self.contentBottomConstraint.constant = - ([UIScreen mainScreen].bounds.size.height - keyboardEndFrame.origin.y);
//        [self.view layoutIfNeeded];
//
//    }];
}


#pragma mark InputAccessoryViewDelegate
- (void)inputAccessoryViewDidSelect:(INPUT_OPERATION_ENUM)operation
{
    if (operation != OPERATION_SHOW_KEYBOARD)
    {
        [self.view endEditing:YES];
        self.inputType = INPUT_KEYBOARD_TYPE_PANEL;
    }
    else
    {
        self.inputType = INPUT_KEYBOARD_TYPE_KEYBOARD;
        [self.inputAccesoryView becomeFirstResponder];
    }
}
@end
