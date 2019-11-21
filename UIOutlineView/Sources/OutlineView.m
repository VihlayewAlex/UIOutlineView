//
//  UIOutlineView.m
//  Photon
//
//  Created by Alex on 24.10.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "OutlineView.h"

@interface UIOutlineView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SRTree* contentTree;
@property (strong, nonatomic) NSArray<SRTree*>* orderedContentArray;

@end

@implementation UIOutlineView

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    [self setDelegate:self];
    [self setDataSource:self];
}

- (void)reloadData
{
    _contentTree = [[SRTree alloc] init];
    _orderedContentArray = [[NSArray alloc] init];
    [self createContentTreeWithParent:_contentTree fromItem:nil];
    [self rebuildContentArray];
    
    [super reloadData];
}

- (void)rebuildContentArray
{
    _orderedContentArray = [_contentTree getChildrenInOrder];
}

- (void)createContentTreeWithParent:(SRTree *)parent fromItem:(id)item
{
    NSInteger count = [_outline_dataSource outlineView:self numberOfChildrenOfItem:item];
    for (int index = 0; index < count; index++) {
        id object = [_outline_dataSource outlineView:self child:index ofItem:item];
        SRTree * newTree = [[SRTree alloc] init];
        [newTree setObject:object];
        [newTree setIsCollapsed:[_outline_delegate outlineView:self shouldCollappseItem:object]]; // ?
        [parent.children addObject:newTree];
        [self createContentTreeWithParent:newTree fromItem:object];
    }
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    SRTree* node = [_orderedContentArray objectAtIndex:indexPath.row];
    return node.object;
}

#pragma mark UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_orderedContentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRTree* node = [_orderedContentArray objectAtIndex:indexPath.row];
    return [_outline_delegate outlineView:self cellForItem:node.object];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    SRTree* node = [_orderedContentArray objectAtIndex:indexPath.row];
    if ([node isLeaf]) {
        return;
    }
    node.isCollapsed = !node.isCollapsed;
    
    [self rebuildContentArray];
    
    NSMutableArray<NSIndexPath*>* indexPaths = [[NSMutableArray alloc] init];
    for (int i = 0; i < node.children.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:(indexPath.row + i + 1) inSection:0]];
    }
    
    if (node.isCollapsed) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [_outline_delegate outlineView:self didCollapseItem:node.object]; // ?
    } else {
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [_outline_delegate outlineView:self didExpandItem:node.object]; // ?
    }
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(ExpandCollapseDisplaying)]) {
        
        if (node.isCollapsed) {
            [cell performSelector:@selector(collapse)];
        } else {
            [cell performSelector:@selector(expand)];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [_outline_delegate heightForHeader:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [_outline_delegate viewForHeader:self];
}

@end
