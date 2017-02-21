//
//  EmojiPanelView.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "EmojiPanelView.h"
#import "EmojiManager.h"

#define EMOJI_LINE_SPACE (8)
#define EMOJI_ITEM_SIZE (42)
#define EMOJI_PER_PAGE (26)
#define EMOJI_LEFT_RIGHT_PAD (18)
#define EMOJI_TOP_PAD (18)
#define EMOJI_ITEM_SPACE (0)
//@interface EmojiPageView:UIView
//- (void)addEmojiItem:(NSString*) emojiItem;
//@end
//
//@interface EmojiPageView()
//@property(nonatomic,strong) UIScrollView* scrollView;
//@property(nonatomic,strong) NSArray* allEmojiItems;
//@property(nonatomic,strong) NSMutableArray* allBtns;
//@property(nonatomic,assign) NSInteger itemCount;
//@end
//
//@implementation EmojiPageView
//
//- (void)setEmojiArray:(NSArray*)emojiArray
//{
//   
//    self.allEmojiItems = emojiArray;
//    
//    
//    [self setNeedsUpdateConstraints];
//    [self setNeedsLayout];
//}
//
//- (void)updateConstraints
//{
//    [super updateConstraints];
//    [self.allBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    NSInteger i = 0;
//    NSInteger page = 0;
//    NSInteger rowNum = 0;
//    CGFloat xOrigin = EMOJI_LEFT_RIGHT_PAD;
//    CGFloat yOrigin = EMOJI_TOP_PAD;
//    for (NSString* item in self.allEmojiItems)
//    {
//        i++;
//        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.translatesAutoresizingMaskIntoConstraints = NO;
//        btn.tag = i;
//        NSString* imageName = [NSString stringWithFormat:@"Expression_%ld",i];
//        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        [self.scrollView addSubview:btn];
//        [self.allBtns addObject:btn];
//        
//        NSLayoutConstraint* topConstraint = [btn.topAnchor constraintEqualToAnchor:self.topAnchor constant:yOrigin];
//        NSLayoutConstraint* leadingConstraint = [btn.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:xOrigin];
//        NSLayoutConstraint* heightConstraint = [btn.heightAnchor constraintEqualToConstant:EMOJI_ITEM_SIZE];
//        NSLayoutConstraint* widthConstraint = [btn.widthAnchor constraintEqualToConstant:EMOJI_ITEM_SIZE];
//        
//        [self.scrollView addConstraint:topConstraint];
//        [self.scrollView addConstraint:leadingConstraint];
//        [btn addConstraint:heightConstraint];
//        [btn addConstraint:widthConstraint];
//        
//        xOrigin += (EMOJI_ITEM_SIZE + EMOJI_ITEM_SPACE);
//        if (rowNum >= 2)
//        {
//            if (xOrigin + EMOJI_ITEM_SIZE > self.bounds.size.width - EMOJI_LEFT_RIGHT_PAD - (EMOJI_ITEM_SIZE + EMOJI_ITEM_SPACE))
//            {
//                //new a Page
//                xOrigin = EMOJI_LEFT_RIGHT_PAD + self.bounds.size.width;
//                yOrigin = EMOJI_TOP_PAD;
//                rowNum = 0;
//                page ++;
//                
//                
//            }
//            
//        }
//        if (xOrigin + EMOJI_ITEM_SIZE > self.bounds.size.width - EMOJI_LEFT_RIGHT_PAD)
//        {
//            if (rowNum >= 2)
//            {
//                break;
//            }
//            xOrigin = EMOJI_LEFT_RIGHT_PAD;
//            yOrigin += (EMOJI_ITEM_SIZE+EMOJI_LINE_SPACE);
//            rowNum ++;
//        }
//        
//        
//        
//    }
//    
//    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width* ceil(page), 0);
//
//}
//
//- (void)commonInit
//{
//    NSLog(@"EmojiPageView commonInit");
//    self.backgroundColor = [UIColor clearColor];
//    
//    self.scrollView = [UIScrollView new];
//    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:self.scrollView];
//    
//    NSLayoutConstraint* topConstraint = [self.scrollView.topAnchor constraintEqualToAnchor:self.topAnchor];
//    NSLayoutConstraint* bottomConstraint = [self.scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
//    NSLayoutConstraint* leadingConstraint = [self.scrollView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
//    NSLayoutConstraint* trailingConstraint = [self.scrollView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
//    
//    [self addConstraint:topConstraint];
//    [self addConstraint:bottomConstraint];
//    [self addConstraint:leadingConstraint];
//    [self addConstraint:trailingConstraint];
//    
//
//    
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        [self commonInit];
//    }
//    
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self)
//    {
//        [self commonInit];
//    }
//    
//    return self;
//}
//
//@end


@interface EmojiPanelView() <UIScrollViewDelegate>
@property(nonatomic,strong) UIPageControl* pageControl;
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) NSArray* allEmojiItems;
@property(nonatomic,strong) NSMutableArray* allBtns;
@property(nonatomic,assign) NSInteger itemCount;
@end

@implementation EmojiPanelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setEmojiArray:(NSArray*)emojiArray
{
    
    self.allEmojiItems = emojiArray;
    [self.allBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger i = 0;
    NSInteger page = 1;
    NSInteger rowNum = 0;
    CGFloat xOrigin = EMOJI_LEFT_RIGHT_PAD;
    CGFloat yOrigin = EMOJI_TOP_PAD;
    for (NSString* item in self.allEmojiItems)
    {
        i++;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn.tag = i;
        NSString* imageName = [NSString stringWithFormat:@"Expression_%ld",i];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(emojiTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        [self.allBtns addObject:btn];
        
        NSLayoutConstraint* topConstraint = [btn.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:yOrigin];
        NSLayoutConstraint* leadingConstraint = [btn.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:xOrigin];
        NSLayoutConstraint* heightConstraint = [btn.heightAnchor constraintEqualToConstant:EMOJI_ITEM_SIZE];
        NSLayoutConstraint* widthConstraint = [btn.widthAnchor constraintEqualToConstant:EMOJI_ITEM_SIZE];
//        NSLog(@"x:%f",xOrigin);
        [self.scrollView addConstraint:topConstraint];
        [self.scrollView addConstraint:leadingConstraint];
        [btn addConstraint:heightConstraint];
        [btn addConstraint:widthConstraint];
        
        xOrigin += (EMOJI_ITEM_SIZE + EMOJI_ITEM_SPACE);
        if (rowNum >= 2)
        {
            if (xOrigin + EMOJI_ITEM_SIZE > [[UIScreen mainScreen] bounds].size.width*page - EMOJI_LEFT_RIGHT_PAD - (EMOJI_ITEM_SIZE + EMOJI_ITEM_SPACE))
            {
                //new a Page
                xOrigin = EMOJI_LEFT_RIGHT_PAD + [[UIScreen mainScreen] bounds].size.width*page;
                yOrigin = EMOJI_TOP_PAD;
                rowNum = 0;
                page ++;
                
                
            }
            
        }
        else if (xOrigin + EMOJI_ITEM_SIZE > [[UIScreen mainScreen] bounds].size.width*page - EMOJI_LEFT_RIGHT_PAD)
        {
            if (rowNum >= 2)
            {
                break;
            }
            xOrigin = EMOJI_LEFT_RIGHT_PAD + [[UIScreen mainScreen] bounds].size.width*(page - 1);
            yOrigin += (EMOJI_ITEM_SIZE+EMOJI_LINE_SPACE);
            rowNum ++;
        }
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width* ceil(page), 0);
    self.pageControl.numberOfPages = page;
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

- (void)updateConstraints
{
    [super updateConstraints];

    
}

- (void)commonInit
{
    NSLog(@"EmojiPageView commonInit");
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
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

    [self setEmojiArray:[EmojiManager shareInstance].kEmotionStringArray];//must be end of init;

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

- (void)emojiTapped:(UIButton*)btn
{
    NSInteger tag = btn.tag - 1;
    NSString* emojiContent = [[EmojiManager shareInstance] emotionStringFromLocalIndex:tag];
    if ([self.delegate respondsToSelector:@selector(didSelectEmojiContent:)])
    {
        [self.delegate didSelectEmojiContent:emojiContent];
    }
}


@end
