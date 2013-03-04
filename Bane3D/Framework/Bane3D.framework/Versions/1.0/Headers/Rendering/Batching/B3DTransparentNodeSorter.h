//
//  B3DTransparentNodeSorter.h
//  Bane3D
//
//  Created by Andreas Hanft on 09.12.11.
//
//
//  Copyright (C) 2012 Andreas Hanft (talantium.net)
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included
//  in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

@class B3DSpriteBatcher;
@class B3DVisibleNode;


@interface B3DTransparentNodeSorter : NSObject

#if DEBUG_PRINT_STATS_BATCHING
@property (nonatomic, readonly) int nodeCount;
@property (nonatomic, readonly) int nodeCountBatched;
@property (nonatomic, readonly) int nodeCountSingle;
@property (nonatomic, readonly) int nodeCountLastFrame;
@property (nonatomic, readonly) int nodeCountBatchedLastFrame;
@property (nonatomic, readonly) int nodeCountSingleLastFrame;
#endif

@property (nonatomic, readonly) BOOL hasNodes;

- (id) initWithSharedBatcher:(B3DSpriteBatcher*)spriteBatcher;

- (void) addNode:(B3DVisibleNode*)node;
- (void) render;

@end
