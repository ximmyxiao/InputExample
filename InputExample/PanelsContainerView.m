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
@end

@implementation PanelsContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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




@end
