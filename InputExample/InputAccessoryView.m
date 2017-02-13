//
//  InputAccessoryView.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/9.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "InputAccessoryView.h"
#import "AutoGrowTextViewV2.h"
@interface InputAccessoryView()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet AutoGrowTextViewV2 *textView;
@end

@implementation InputAccessoryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
//    [self.textView setMaxLinesToDisplay:5];
    self.backgroundColor = HEXCOLOR(0xf4f4f4);
}
+ (instancetype) InputAccessoryViewInstance
{
//    UIView* view = [UIView new];
//    view.backgroundColor = [UIColor redColor];
//    return view;
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InputAccessoryView"owner:self options:nil];
    return objects[0];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"textViewDidChange");
    AutoGrowTextViewV2* autoGrowTextView = (AutoGrowTextViewV2*) textView;
    [autoGrowTextView textViewDidChange:textView];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
