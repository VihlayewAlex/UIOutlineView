//
//  SRTree.m
//  Photon
//
//  Created by Alex on 25.10.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "SRTree.h"

@implementation SRTree

- (instancetype)init
{
    self = [super init];
    if (self) {
        _children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)isLeaf
{
    return (_children.count == 0);
}

- (NSInteger)nodesCount
{
    NSInteger count = 1;
    for (SRTree* node in _children) {
        count += [node nodesCount];
    }
    return count;
}

- (NSArray<SRTree*>*)getChildrenInOrder
{
    if (_object != nil && (_children.count == 0 || _isCollapsed)) {
        return @[self];
    }
    NSArray<SRTree*>* subChildren = @[];
    for (SRTree* child in _children) {
        subChildren = [subChildren arrayByAddingObjectsFromArray:[child getChildrenInOrder]];
    }
    // Result
    if (_object != nil) {
        return [@[self] arrayByAddingObjectsFromArray:subChildren];
    } else {
        return subChildren;
    }
}

@end
