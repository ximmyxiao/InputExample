//
//  AutoGrowTextViewV2.h
//  testAutoGrowTextView
//
//  Created by Piao Piao on 15/10/26.
//  Copyright © 2015年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>

//must call AutoGrowTextViewV2's textViewDidChange in AutoGrowTextViewV2's delegate;
@interface AutoGrowTextViewV2 : UITextView <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView;
- (void)setMaxLinesToDisplay:(NSInteger) maxLineNumber;
@end
