//
//  SGLoadingScene.m
//  SampleGame
//
//  Created by Andreas Hanft on 04.03.13.
//  Copyright (c) 2013 talantium.net. All rights reserved.
//

#import "SGLoadingScene.h"

#import "SGMenuScene.h"


const   CGSize          SGLoadingBarSize          = {456/2, 6/2}; // Retina was used to measure
const   CGFloat         SGLoadingBarTopDistance   = 390/2;        // Retina was used to measure


@interface SGLoadingScene ()

@property (nonatomic, readwrite, strong) B3DGUIImage*			loadingBar;
@property (nonatomic, readwrite, strong) B3DGUIButton*			buttonContinue;

@end


@implementation SGLoadingScene

- (void) assetList
{
	[self registerAssetForUse:[B3DTexturePNG textureNamed:[B3DGUIDefaultSplashImage defaultTextureName]]];
//	[self registerAssetForUse:[B3DTexturePNG textureNamed:@"touch_to_continue"]];
}

- (id) init
{
	self = [super init];
	if (self != nil)
	{
        CGSize screenSize = [UIApplication currentSize];
        
		[self addSubNode:[B3DGUIDefaultSplashImage landscapeImage]];
        
//		self.buttonContinue = [[B3DGUIButton alloc] initWithSize:screenSize
//                                                        andColor:[B3DColor colorWithRed:0 green:0 blue:0 alpha:0]];
//		{
//			[self.buttonContinue setPositionToX:0 andY:0 andZ:-10.0f];
//            self.buttonContinue.visible = NO;
//            
//            B3DGUIImage* image = [[B3DGUIImage alloc] initWithPNGTexture:@"touch_to_continue"];
//            [image awakeWithBlock:^(B3DBaseNode* node)
//            {
//                CGSize size = ((B3DGUIImage*)node).size;
//                [node setPositionToX:_loadingBar.position.x + SGLoadingBarSize.width - size.width
//                                andY:104
//                                andZ:4.0f];
//            }];
//            [self.buttonContinue addSubNode:image];
//            
//            B3DTimer* blinkTimer = [[B3DTimer alloc] initWithTarget:self
//                                                             action:@selector(blinkTouchToStart:)
//                                                             object:image
//                                                              delay:0.9
//                                                            repeats:YES];
//            [self.buttonContinue addSubNode:blinkTimer];
//		}
//		[self addSubNode:self.buttonContinue];
        
        self.loadingBar = [[B3DGUIImage alloc] initWithSize:CGSizeMake(SGLoadingBarSize.width * 0.02, SGLoadingBarSize.height)
                                                   andColor:[B3DColor whiteColor]];
		{
			[self.loadingBar setPositionToX:screenSize.width/2 - SGLoadingBarSize.width/2 // center X
                                       andY:screenSize.height - SGLoadingBarTopDistance - SGLoadingBarSize.height
                                       andZ:-128.0f];
			self.loadingBar.visible = NO;
		}
		[self addSubNode:self.loadingBar];
	}
	
	return self;
}

- (void) becameVisible
{
	[super becameVisible];
	
	self.handleSceneLoadingEvents = YES;
    
    NSString* sceneToLoadKey = NSStringFromClass([SGMenuScene class]);

	B3DTimer* timer = [[B3DTimer alloc] initWithTarget:self.sceneManager
												action:@selector(loadSceneWithKey:)
												object:sceneToLoadKey
												 delay:0.1
											   repeats:NO];
	[self addSubNode:timer];
}

- (void) sceneLoadingDidBeganForScene:(B3DScene*)scene
{
	self.loadingBar.visible = YES;
}

- (void) sceneLoadingForScene:(B3DScene*)scene didAchieveProgress:(float)progress
{
	self.loadingBar.size = CGSizeMake(SGLoadingBarSize.width * progress, SGLoadingBarSize.height);
}

- (void) sceneLoadingDidFinishSuccessfulForScene:(B3DScene*)scene
{
    if (self.buttonContinue)
    {
        self.buttonContinue.visible = YES;
        [self.buttonContinue setAction:@selector(startButtonTouched:) forTarget:self withObject:scene];
        
    }
    else
    {
        [self.sceneManager setSceneAsVisible:scene];
    }
}

- (void) startButtonTouched:(id)scene
{
    [self.sceneManager setSceneAsVisible:scene];
}

- (void) blinkTouchToStart:(B3DGUIImage*)image
{
    image.visible = !image.visible;
}


@end
