//
//  SNCollectionViewCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCellItem.h"
#import "SNCollectionViewCell.h"
#import "NSString+SNAdditions.h"

@interface SNCollectionViewCellItem ()

@property (nonatomic, strong) UICollectionViewLayoutAttributes *originalLayoutAttributes;

@end

@implementation SNCollectionViewCellItem

- (CGFloat)cellWidth {
    if (0 == _cellWidth) {
        return self.layoutAttributes.frame.size.width;
    }
    return _cellWidth;
}

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.cellClass = [SNCollectionViewCell class];
    self.selectable = YES;
    self.deselectAfterSelecting = YES;
    
    return self;
}

//  Generate the identifier based on the cell's class
- (NSString *)identifier {
    if (_identifier == nil) {
        _identifier = [[NSString alloc] initWithFormat:@"CollectionCell%@Identifier", [[self.nibName sn_trim] length] ? self.nibName : self.cellClass];
    }
    return _identifier;
}

- (void)updateOriginalLayoutAttributes:(UICollectionViewLayoutAttributes *)newOriginalLayoutAttributes {
    self.originalLayoutAttributes = newOriginalLayoutAttributes;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%p: %@ - %@ - %@", self, [[self class] description], self.indexPath, NSStringFromCGRect(self.layoutAttributes.frame)];
}

@end
