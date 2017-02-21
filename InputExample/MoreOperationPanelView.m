//
//  MoreOperationPanelView.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "MoreOperationPanelView.h"


#define MORE_OPERATION_LINE_SPACE (16)
#define MORE_OPERATION_ITEM_WIDTH (61)
#define MORE_OPERATION_ITEM_HEIGHT (78)
#define MORE_OPERATION_TOP_PAD (12)



@implementation OperationItem

- (instancetype)initWithTitle:(NSString*)title andImageName:(NSString*) imageName
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.imageName = imageName;
    }
    return self;
}

@end

@interface MoreOperationPanelView()
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UIPageControl* pageControl;
@property(nonatomic,strong) NSMutableArray* allBtns;
@end

@implementation MoreOperationPanelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)commonInit
{
    self.backgroundColor = HEXCOLOR(0xf5f5f5);
    self.clipsToBounds = YES;
    self.scrollView = [UIScrollView new];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    
    NSLayoutConstraint* topConstraint = [self.scrollView.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint* bottomConstraint = [self.scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    NSLayoutConstraint* leadingConstraint = [self.scrollView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint* trailingConstraint = [self.scrollView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    [self addConstraint:topConstraint];
    [self addConstraint:bottomConstraint];
    [self addConstraint:leadingConstraint];
    [self addConstraint:trailingConstraint];
    
    self.pageControl = [UIPageControl new];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.pageIndicatorTintColor = HEXCOLOR(0xd5d5d5);
    self.pageControl.currentPageIndicatorTintColor = HEXCOLOR(0x8b8b8b);
    [self addSubview:self.pageControl];
    
    NSLayoutConstraint* pageBottomConstraint = [self.pageControl.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
    NSLayoutConstraint* pageLeadingConstraint = [self.pageControl.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint* pageTrailingConstraint = [self.pageControl.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    [self addConstraint:pageBottomConstraint];
    [self addConstraint:pageLeadingConstraint];
    [self addConstraint:pageTrailingConstraint];
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

- (void)setAllOperationItems:(NSArray *)allOperationItems
{
    
    _allOperationItems = allOperationItems;
    [self.allBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger i = 0;
    NSInteger page = 1;
    NSInteger rowNum = 0;
    CGFloat pad = ([[UIScreen mainScreen] bounds].size.width - 4*MORE_OPERATION_ITEM_WIDTH)/5;
    CGFloat xOrigin = pad;
    CGFloat yOrigin = MORE_OPERATION_TOP_PAD;
    for (OperationItem* item in self.allOperationItems)
    {
        i++;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn.tag = i;
        NSString* imageName = item.imageName;
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setTitle:item.title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 17, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(MORE_OPERATION_ITEM_HEIGHT - 17, -MORE_OPERATION_ITEM_WIDTH, 0, 0)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        NSInteger rgb = 0x888888;
        [btn setTitleColor:[UIColor colorWithRed:(((rgb & 0xFF0000) >> 16))/255.0 green:(((rgb & 0xFF00) >> 8))/255.0 blue:((rgb & 0xFF))/255.0 alpha:1] forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];
        [self.allBtns addObject:btn];
        
        NSLayoutConstraint* topConstraint = [btn.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:yOrigin];
        NSLayoutConstraint* leadingConstraint = [btn.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:xOrigin];
        NSLayoutConstraint* heightConstraint = [btn.heightAnchor constraintEqualToConstant:MORE_OPERATION_ITEM_HEIGHT];
        NSLayoutConstraint* widthConstraint = [btn.widthAnchor constraintEqualToConstant:MORE_OPERATION_ITEM_WIDTH];
        //        NSLog(@"x:%f",xOrigin);
        [self.scrollView addConstraint:topConstraint];
        [self.scrollView addConstraint:leadingConstraint];
        [btn addConstraint:heightConstraint];
        [btn addConstraint:widthConstraint];
        
        xOrigin += (MORE_OPERATION_ITEM_WIDTH + pad);

        if (xOrigin + MORE_OPERATION_ITEM_WIDTH > [[UIScreen mainScreen] bounds].size.width*page - pad)
        {
            if (rowNum >= 1)
            {
                if (xOrigin + MORE_OPERATION_ITEM_WIDTH > [[UIScreen mainScreen] bounds].size.width*page - pad)
                {
                    //new a Page
                    xOrigin = MORE_OPERATION_ITEM_WIDTH + [[UIScreen mainScreen] bounds].size.width*page;
                    yOrigin = MORE_OPERATION_TOP_PAD;
                    rowNum = 0;
                    page ++;
                    continue;
                    
                }
                
            }

            xOrigin = pad + [[UIScreen mainScreen] bounds].size.width*(page - 1);
            yOrigin += (MORE_OPERATION_ITEM_HEIGHT+MORE_OPERATION_LINE_SPACE);
            rowNum ++;
        }
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width* ceil(page), 0);
    self.pageControl.numberOfPages = page;
    if (page == 1)
    {
        self.pageControl.alpha = 0;
    }
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

- (void)moreBtnTapped:(UIButton*)btn
{
    
}

@end
