//
//  SNCollectionViewCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SNCollectionViewDelegate.h"

@class SNCollectionViewCell;
@class UICollectionViewLayoutAttributes;

typedef NS_OPTIONS(NSInteger, SNCollectionCellItemParallaxStyle) {
    SNCollectionCellItemParallaxStyleNone = 0 << 0,
    SNCollectionCellItemParallaxStyleShorten = 1 << 4,
    SNCollectionCellItemParallaxStyleStretch = 2 << 4,
    SNCollectionCellItemParallaxStyleShortenAndStretch = SNCollectionCellItemParallaxStyleShorten | SNCollectionCellItemParallaxStyleStretch,
};

@interface SNCollectionViewCellItem : NSObject

// Subclasses must set one of these two properties and use it to return the cell class or nib file name of the cell's view.
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, copy) NSString *nibName;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) id rawObject;
@property (nonatomic, weak) SNCollectionViewCell *cell;

// the collection of the cell
@property (nonatomic, weak) SNCollectionView *collectionView;

@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellLeftMargin;
@property (nonatomic, assign) CGFloat cellTopMargin; //可以定制，默认是0，会和rowSpace加和
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *layoutAttributes;
@property (nonatomic, strong, readonly) UICollectionViewLayoutAttributes *originalLayoutAttributes;
@property (nonatomic, assign) SNCollectionCellItemParallaxStyle parallaxStyle;

@property (nonatomic, assign) BOOL selectable;
@property (nonatomic, assign) BOOL deselectAfterSelecting;
@property (nonatomic, assign) BOOL selected;

- (void)updateOriginalLayoutAttributes:(UICollectionViewLayoutAttributes *)newOriginalLayoutAttributes;

@end
