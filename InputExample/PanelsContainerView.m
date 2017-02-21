//
//  PanelsContainerView.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "PanelsContainerView.h"
#import "EmojiPanelView.h"
#import "MoreOperationPanelView.h"

@interface PanelsContainerView()
@property(nonatomic,strong) EmojiPanelView* emojiPanel;
@property(nonatomic,strong) MoreOperationPanelView* morePanel;
@end

@implementation PanelsContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setDelegate:(id<EmojiPanelViewDelegate>)delegate
{
    _delegate = delegate;
    self.emojiPanel.delegate = self.delegate;
}
- (void)commonInit
{
    NSLog(@"commonInit");
    self.backgroundColor = [UIColor clearColor];
    
    self.emojiPanel = [EmojiPanelView new];
    self.emojiPanel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.emojiPanel];
    
    NSLayoutConstraint* topEmojiConstraint = [self.emojiPanel.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint* leadingEmojiConstraint = [self.emojiPanel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint* bottomEmojiConstraint = [self.emojiPanel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    NSLayoutConstraint* trailingEmojiConstraint = [self.emojiPanel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    [self addConstraint:topEmojiConstraint];
    [self addConstraint:leadingEmojiConstraint];
    [self addConstraint:bottomEmojiConstraint];
    [self addConstraint:trailingEmojiConstraint];
    
    
    self.morePanel = [MoreOperationPanelView new];
    self.morePanel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.morePanel];
    
    NSLayoutConstraint* topMoreConstraint = [self.morePanel.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint* leadingMoreConstraint = [self.morePanel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint* bottomMoreConstraint = [self.morePanel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    NSLayoutConstraint* trailingMoreConstraint = [self.morePanel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    [self addConstraint:topMoreConstraint];
    [self addConstraint:leadingMoreConstraint];
    [self addConstraint:bottomMoreConstraint];
    [self addConstraint:trailingMoreConstraint];
    
    [self sendSubviewToBack:self.morePanel];
    
    OperationItem* item1 = [[OperationItem alloc] initWithTitle:@"照片" andImageName:@"PhotoIcon"];
    OperationItem* item2 = [[OperationItem alloc] initWithTitle:@"拍摄" andImageName:@"CameraIcon"];
    OperationItem* item3 = [[OperationItem alloc] initWithTitle:@"视频聊天" andImageName:@"VideoChatIcon"];
    OperationItem* item4 = [[OperationItem alloc] initWithTitle:@"位置" andImageName:@"LocationIcon"];
    OperationItem* item5 = [[OperationItem alloc] initWithTitle:@"语音输入" andImageName:@"VoiceInput"];
    
    NSArray* allItems = @[item1,item2,item3,item4,item5];
    self.morePanel.allOperationItems = allItems;

    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}


- (void)showPanel:(INPUT_OPERATION_ENUM) panel
{
    if (panel == OPERATION_SHOW_EMOJI)
    {
        [self bringSubviewToFront:self.emojiPanel];
    }
    else if (panel == OPERATION_SHOW_MORE_MENU)
    {
        [self bringSubviewToFront:self.morePanel];
    }
}

@end
