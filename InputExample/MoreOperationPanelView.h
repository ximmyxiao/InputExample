//
//  MoreOperationPanelView.h
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationItem : NSObject
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* imageName;
- (instancetype)initWithTitle:(NSString*)title andImageName:(NSString*) imageName;
@end

@interface MoreOperationPanelView : UIView
@property(nonatomic,strong) NSArray* allOperationItems;
@end
