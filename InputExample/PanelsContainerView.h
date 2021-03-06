//
//  PanelsContainerView.h
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiPanelView.h"
#import "InputAccessoryView.h"

@interface PanelsContainerView : UIView
@property(nonatomic,weak) id<EmojiPanelViewDelegate> delegate;
- (void)showPanel:(INPUT_OPERATION_ENUM) panel;

@end
