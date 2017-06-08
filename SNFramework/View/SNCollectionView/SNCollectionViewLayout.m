//
//  SNCollectionViewLayout.m
//  QDaily
//
//  Created by AsnailNeo on 3/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewLayout.h"
#import "SNCollectionView.h"
#import "SNCollectionViewLoadingCellItem.h"
#import "SNCollectionViewEmptyCellItem.h"
#import "SNCollectionViewLoadingMoreCellItem.h"
#import "SNCollectionViewPlaceholderCellItem.h"
#import "SNFrameworkGlobal.h"

@interface SNCollectionViewLayout ()

@property (nonatomic, assign) CGPoint lastCellLeftBottom;

- (void)updateParallaxEffectWithCellItem:(SNCollectionViewCellItem *)cellItem;

@end

@implementation SNCollectionViewLayout

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.lastCellItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    return self;
}

#pragma mark -
#pragma mark Getter & Setter

- (void)setHeaderViewMargin:(CGFloat)headerViewMargin {
    if (_headerViewMargin != headerViewMargin) {
        _headerViewMargin = headerViewMargin;
        [self invalidateLayout];
    }
}

- (SNCollectionView *)lfCollectionView {
    if ([self.collectionView isKindOfClass:[SNCollectionView class]]) {
        return (SNCollectionView *)self.collectionView;
    } else {
        LogE(@"Invalid Collection View Type!");
        return nil;
    }
}

- (CGSize)collectionViewContentSize {
    if (self.extendContentSize && self.lastCellLeftBottom.y < self.collectionView.frame.size.height) {
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    }
    return CGSizeMake(self.collectionView.frame.size.width, self.lastCellLeftBottom.y);
}

#pragma mark -
#pragma mark UICollectionViewLayout Subcalssing

- (CGPoint)prepareLayoutattributesForCellItem:(SNCollectionViewCellItem *)cellItem
                           withCollectionView:(SNCollectionView *)collectionView
{
    if ([cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
        cellItem.layoutAttributes.frame = rm(0, self.lastCellLeftBottom.y, self.lfCollectionView.width, cellItem.cellHeight);
    }

    return pm(cellItem.layoutAttributes.frame.origin.x, cellItem.layoutAttributes.frame.origin.y + cellItem.layoutAttributes.frame.size.height);
}

- (void)invalidateLayout {
    [super invalidateLayout];
}

- (void)resetLayoutProperties {
    self.lastCellLeftBottom = pm(0, self.headerViewMargin);
    self.lastCellItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
}

- (void)prepareLayout {
    
    if (!self.lfCollectionView) {
        LogE(@"Invalid Collection View Type!");
        return;
    }
    if (!self.onlyCalculateNewAddedItems) {
        [self resetLayoutProperties];
    }

    [super prepareLayout];
    
    [self willPrepareLayout];
    
    NSUInteger item = self.onlyCalculateNewAddedItems ? self.lastCellItemIndexPath.item : 0;
    NSUInteger section = self.onlyCalculateNewAddedItems ? self.lastCellItemIndexPath.section : 0;
    
    NSMutableArray *sections = [self.lfCollectionView.lfDelegate cellItemSectionsForCollectionView:self.lfCollectionView];
    
    for (NSUInteger sectionIndex = section; sectionIndex < sections.count; sectionIndex++) {
        NSMutableArray *cellItems = [sections sn_dataSourceOfSection:sectionIndex];
        for (NSUInteger itemIndex = item; itemIndex < cellItems.count; itemIndex++) {
            SNCollectionViewCellItem *cellItem = [cellItems objectAtIndex:itemIndex];
            if ([cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];
                
                if (!cellItem.layoutAttributes) {
                    cellItem.layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                }
                
                cellItem.indexPath = indexPath;
                cellItem.layoutAttributes.indexPath = indexPath;
                
                self.lastCellLeftBottom = [self prepareLayoutattributesForCellItem:cellItem withCollectionView:self.lfCollectionView];
                
                if (cellItem.parallaxStyle != SNCollectionCellItemParallaxStyleNone) {
                    [cellItem updateOriginalLayoutAttributes:cellItem.layoutAttributes];
                }
                
                self.lastCellItemIndexPath = [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];
                
            } else {
                NSAssert(NO, @"Invalid SNCollectionViewCellItem!");
            }
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SNCollectionViewCellItem *cellItem = [[self.lfCollectionView cellItemsOfSection:indexPath.section] sn_objectAtSafeIndex:indexPath.item];
    if ([cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
        if (!cellItem.layoutAttributes) {
            cellItem.layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        }
        return cellItem.layoutAttributes;
    } else {
        LogE(@"Invalid SNCollectionViewCellItem!");
        return [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    for (NSMutableArray *sections in [self.lfCollectionView.lfDelegate cellItemSectionsForCollectionView:self.lfCollectionView]) {
        if ([sections isKindOfClass:[NSMutableArray class]]) {
            [sections enumerateObjectsUsingBlock:^(SNCollectionViewCellItem *cellItem, NSUInteger idx, BOOL *stop) {
                if ([cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
                    if (CGRectIntersectsRect(rect, cellItem.layoutAttributes.frame)) {
                        [self updateParallaxEffectWithCellItem:cellItem];
                        [layoutAttributes sn_addNonnilObject:cellItem.layoutAttributes];
                    }
                }
            }];
        }
    }
    
    return layoutAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return self.invalidateLayoutWhenBoundsChange;
}

#pragma mark -
#pragma mark Template Method

- (void)willPrepareLayout {
    
}

#pragma mark -
#pragma mark Private

- (void)updateParallaxEffectWithCellItem:(SNCollectionViewCellItem *)cellItem {
    
    if (cellItem.parallaxStyle == SNCollectionCellItemParallaxStyleNone) {
        return;
    }
    
    UIEdgeInsets insets = self.collectionView.contentInset;
    CGPoint offset = self.collectionView.contentOffset;
    
    CGFloat minY = -insets.top;
    CGSize  referenceSize = cellItem.originalLayoutAttributes.frame.size;
    CGFloat deltaY = fabs(offset.y - minY);
    
    if ((cellItem.parallaxStyle & SNCollectionCellItemParallaxStyleStretch) && offset.y < minY) {
        CGRect layoutRect = cellItem.layoutAttributes.frame;
        layoutRect.size.height = MAX(minY, referenceSize.height + deltaY);
        layoutRect.origin.y = layoutRect.origin.y - deltaY;
        [cellItem.layoutAttributes setFrame:layoutRect];
    }
    
    if ((cellItem.parallaxStyle & SNCollectionCellItemParallaxStyleShorten) && offset.y > minY) {
        CGRect layoutRect = cellItem.layoutAttributes.frame;
        layoutRect.size.height = MAX(minY, referenceSize.height - deltaY);
        layoutRect.origin.y = layoutRect.origin.y + deltaY;
        [cellItem.layoutAttributes setFrame:layoutRect];
    }
}

@end
