//
//  SGMenuScene.m
//  SampleGame
//
//  Created by Andreas Hanft on 04.03.13.
//  Copyright (c) 2013 talantium.net. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#import "SGMenuScene.h"

#import "SGShaderDemoScene.h"
#import "SGButton.h"


@implementation SGMenuScene

- (void) assetList
{
    [super assetList];
    
	[self registerAssetForUse:[B3DMesh3DS meshNamed:@"Teddy"]];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        CGSize screenSize = [UIApplication currentSize];
        
        B3DLabel* label = [[B3DLabel alloc] initWithFontNamed:SGCommonBaseSceneFontName size:SGCommonBaseSceneFontSize];
        label.color = [B3DColor colorWithRGBHex:0xcccccc];
        [label translateByX:2 andY:screenSize.height - 22 andZ:-3];
        [label updateWithBlock:^(B3DBaseNode* node, double deltaTime)
        {
            ((B3DLabel*)node).text = [NSString stringWithFormat:NSLocalizedString(@"SGFPSLabelText", nil), 1.0f/deltaTime];
        }];
        [self addSubNode:label];
        
        B3DBaseModelNode* model = [[B3DBaseModelNode alloc] initWithMesh:@"Teddy" ofType:B3DAssetMesh3DSDefaultExtension
                                                                 texture:nil ofType:nil];
        {
            model.renderer = B3DBaseModelNodeRendererLine;
            [model translateByX:0 andY:1 andZ:-4];
            [model rotateByX:-90 andY:0 andZ:0];
            [model updateWithBlock:^(B3DBaseNode* node, double deltaTime)
             {
                 [node rotateByAngle:30 * deltaTime aroundX:1 andY:1 andZ:0];
             }];
        }
        [self addSubNode:model];
        
        SGButton* button = [SGButton buttonWithText:NSLocalizedString(@"SGMenuSceneShaderDemoButtonLabelText", nil)];
        {
            [button setPositionToX:24 andY:196 andZ:-3];
            [button setAction:@selector(presentSceneWithKey:) forTarget:self withObject:NSStringFromClass([SGShaderDemoScene class])];
        }
        [self addSubNode:button];
    }
    
    return self;
}


@end
