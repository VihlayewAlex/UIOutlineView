//
//  OutlineView.h
//  UIOutlineView
//
//  Created by Alex on 21.11.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRTree.h"

NS_ASSUME_NONNULL_BEGIN

@class UIOutlineView;

@protocol UIOutlineViewDataSource <NSObject>

- (NSInteger)outlineView:(UIOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item;

- (id)outlineView:(UIOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item;

- (BOOL)outlineView:(UIOutlineView *)outlineView isItemExpandable:(id)item;

@end


@protocol UIOutlineViewDelegate <NSObject>

- (nullable UITableViewCell *)outlineView:(UIOutlineView *)outlineView cellForItem:(id)item;

- (BOOL)outlineView:(UIOutlineView *)outlineView shouldCollappseItem:(id)item;

- (void)outlineView:(UIOutlineView *)outlineView didExpandItem:(id)item;

- (void)outlineView:(UIOutlineView *)outlineView didCollapseItem:(id)item;

- (UIView *)viewForHeader:(UIOutlineView *)outlineView;

- (CGFloat)heightForHeader:(UIOutlineView *)outlineView;

@end


@protocol ExpandCollapseDisplaying <NSObject>

- (void)expand;

- (void)collapse;

@end


@interface UIOutlineView : UITableView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"

@property (nonatomic, nullable, weak) id <UIOutlineViewDelegate> outline_delegate;
@property (nonatomic, nullable, weak) id <UIOutlineViewDataSource> outline_dataSource;

#pragma clang diagnostic pop

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
