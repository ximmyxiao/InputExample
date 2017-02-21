//
//  EmojiPanelView.h
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EmojiPanelViewDelegate<NSObject>
- (void)didSelectEmojiContent:(NSString*)content;
@end

@interface EmojiPanelView : UIView
- (void)setEmojiArray:(NSArray*)emojiArray;
@property(nonatomic,weak) id<EmojiPanelViewDelegate> delegate;
@end
