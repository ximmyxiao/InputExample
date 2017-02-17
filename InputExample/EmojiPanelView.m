//
//  EmojiPanelView.m
//  InputExample
//
//  Created by Piao Piao on 2017/2/16.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "EmojiPanelView.h"
#import "EmojiManager.h"
#define EMOJI_PER_PAGE (26)

@interface EmojiPageView:UIView
- (void)addEmojiItem:(NSString*) emojiItem;
@end

@interface EmojiPageView()
@property(nonatomic,strong) NSMutableArray* allEmojiItems;
@property(nonatomic,strong) NSMutableArray* allBtns;
@end

@implementation EmojiPageView

- (void)addEmojiItem:(NSString *)emojiItem
{
    if (self.allEmojiItems == nil)
    {
        self.allEmojiItems = [NSMutableArray array];
    }
    
    [self.allEmojiItems addObject:emojiItem];
    
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.allBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSString* item in self.allEmojiItems)
    {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn = 
    }
}

@end


@interface EmojiPanelView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) NSArray* allEmojis;
@end

@implementation EmojiPanelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)commonInit
{
    NSLog(@"EmojiPanelView commonInit");
    self.backgroundColor = [UIColor clearColor];

    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(40, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EmojiCell"];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    

    
    NSLayoutConstraint* topCVConstraint = [self.collectionView.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint* leadingCVConstraint = [self.collectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint* bottomCVConstraint = [self.collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    NSLayoutConstraint* trailingCVConstraint = [self.collectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    [self addConstraint:topCVConstraint];
    [self addConstraint:leadingCVConstraint];
    [self addConstraint:bottomCVConstraint];
    [self addConstraint:trailingCVConstraint];
    
    self.allEmojis = [EmojiManager shareInstance].kEmotionStringArray;
    
    
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger sectionCount = 0;
    if ([self.allEmojis count] > 0)
    {
        sectionCount = 1;
    }
    return sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.allEmojis count] ;


}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCell" forIndexPath:indexPath];
    [[cell.contentView viewWithTag:'imgv'] removeFromSuperview];
    NSString* imageName = [NSString stringWithFormat:@"Expression_%ld",indexPath.row+1];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.tag = 'imgv';
    [cell.contentView addSubview:imageView];
    return cell;
}


@end
