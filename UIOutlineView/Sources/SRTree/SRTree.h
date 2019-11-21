//
//  SRTree.h
//  Photon
//
//  Created by Alex on 25.10.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRTree : NSObject

@property (strong, nonatomic) id object;
@property (assign, nonatomic) BOOL isCollapsed;
@property (strong, nonatomic) NSMutableArray<SRTree*>* children;

- (BOOL)isLeaf;

- (NSInteger)nodesCount;

- (NSArray<SRTree*>*)getChildrenInOrder;

@end

NS_ASSUME_NONNULL_END
