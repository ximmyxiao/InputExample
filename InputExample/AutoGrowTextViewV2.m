//
//  AutoGrowTextViewV2.m
//  testAutoGrowTextView
//
//  Created by Piao Piao on 15/10/26.
//  Copyright © 2015年 Piao Piao. All rights reserved.
//

#import "AutoGrowTextViewV2.h"

@implementation AutoGrowTextViewV2

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.delegate = self;
        self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.font = [UIFont systemFontOfSize:16];

    }
    return self;
}

- (void)setMaxLinesToDisplay:(NSInteger) maxLineNumber
{
    self.textContainer.maximumNumberOfLines = maxLineNumber;
    self.textContainer.lineBreakMode = NSLineBreakByClipping;

}

- (CGSize)intrinsicContentSize
{
    CGSize size =  [self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)];
    if (size.height > 98)
    {
        size = CGSizeMake(size.width, 98);
    }
    return size;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self invalidateIntrinsicContentSize];
    [self layoutIfNeeded];
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
}


@end
