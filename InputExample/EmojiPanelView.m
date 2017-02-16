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
    self.backgroundColor = [UIColor clearColor];

    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(40, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
    NSInteger pages =  (NSInteger)(ceil ([self.allEmojis count]*1.0 / EMOJI_PER_PAGE));
    return pages;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger pages =  (NSInteger)(ceil ([self.allEmojis count]*1.0 / EMOJI_PER_PAGE));
    if (section < pages - 1)
    {
        return 26;
    }
    else if (section == pages - 1)
    {
        return [self.allEmojis count] % 26;
    }
    else
    {
        return 0;
    }

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCell" forIndexPath:indexPath];
    NSString* imageName = [NSString stringWithFormat:@"Expression_%ld",indexPath.row+1];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [cell.contentView addSubview:imageView];
    return cell;
}


@end
