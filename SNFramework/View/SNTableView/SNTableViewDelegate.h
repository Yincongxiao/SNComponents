//
//  SNTableViewDelegate.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNTableView;
@class SNTableCellItem;
@class SNTableViewCell;

@protocol SNTableViewDelegate <NSObject>

@required
#pragma mark - DataSource
- (NSMutableArray *)cellItemsForTableView:(SNTableView *)tableView;

@optional

#pragma mark - TableView Delegate
- (void)tableView:(SNTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(SNTableCellItem *)cellItem;
- (void)tableView:(SNTableView *)tableView willDisplayCell:(SNTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(SNTableCellItem *)cellItem;
- (void)tableView:(SNTableView *)tableView setItemforCell:(SNTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(SNTableCellItem *)cellItem;
- (void)tableView:(SNTableView *)tableView setCreatedItemforCell:(SNTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(SNTableCellItem *)cellItem;

#pragma mark - Update DataSource

- (void)moreItemsWillLoadWithTableView:(SNTableView *)tableView;

#pragma mark - Table Cell Actions

- (void)tableView:(SNTableView *)tableView
actionOnTableCell:(SNTableViewCell *)lbCell
      atIndexPath:(NSIndexPath *)indexPath
    tableCellItem:(SNTableCellItem *)cellItem
          control:(id)control
     controlEvent:(UIControlEvents)event
         userInfo:(id)userInfo;

- (void)tableView:(SNTableView *)tableView actionWithSelector:(SEL)selector info:(NSDictionary *)info;

#pragma mark - TableCell Edit Operations
- (void)tableView:(SNTableView *)tableView cellItemDidDelete:(SNTableCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SNTableView *)tableView cellItemDidInsert:(SNTableCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(SNTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

#pragma mark - ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;


@end
