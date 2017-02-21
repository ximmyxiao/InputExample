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
@property (weak, nonatomic) IBOutlet UIButton *emojiBtn;
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
    UIColor* color = HEXCOLOR(0xdddddd);
    self.textView.layer.borderColor = color.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 5;
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
//    [self.textView setMaxLinesToDisplay:5];
    self.backgroundColor = HEXCOLOR(0xf4f4f4);
//    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
//    [self addGestureRecognizer:gesture];
}

- (void)tapGestureAction
{
    
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

- (IBAction)emojiBtnAction:(id)sender {
    UIButton* btn = (UIButton*) sender;
    if (btn.selected == NO)
    {
        [self.delegate inputAccessoryViewDidSelect:OPERATION_SHOW_EMOJI];
        [btn setSelected:YES];
    }
    else
    {
        [self.delegate inputAccessoryViewDidSelect:OPERATION_SHOW_KEYBOARD];
        [btn setSelected:NO];
    }
    
}
- (IBAction)moreBtnAction:(id)sender {
    [self.delegate inputAccessoryViewDidSelect:OPERATION_SHOW_MORE_MENU];

}

- (void)keyboardIsShow
{
    [self.emojiBtn setSelected:NO];

}

- (BOOL)becomeFirstResponder
{
    return [self.textView becomeFirstResponder];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"view touchesEnded");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)didSelectEmojiContent:(NSString *)content
{
    self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,content];
    [self textViewDidChange:self.textView];
}
@end
