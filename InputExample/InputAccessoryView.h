//
//  InputAccessoryView.h
//  InputExample
//
//  Created by Piao Piao on 2017/2/9.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiPanelView.h"

typedef NS_ENUM(NSInteger,INPUT_OPERATION_ENUM) {
    OPERATION_SHOW_KEYBOARD = 0,
    OPERATION_SHOW_EMOJI,
    OPERATION_SHOW_MORE_MENU,
    OPERATION_SHOW_VOICE_PANEL,
    OPERATION_SHOW_VOICE_RECORDING,
};

@protocol InputAccessoryViewDelegate <NSObject>

- (void)inputAccessoryViewDidSelect:(INPUT_OPERATION_ENUM)operation;

@end

@interface InputAccessoryView : UIView<EmojiPanelViewDelegate>

+ (instancetype) InputAccessoryViewInstance;
- (void)keyboardIsShow;
@property(nonatomic,weak) id<InputAccessoryViewDelegate> delegate;
@end
