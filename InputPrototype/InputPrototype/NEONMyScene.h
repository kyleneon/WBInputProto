//
//  NEONMyScene.h
//  InputPrototype
//

//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NEONMyScene : SKScene

- (void) reset;
- (void) nextLaunchHandler;
- (void) nextCatchHandler;

@property (nonatomic, readonly) NSString* currentLaunchHandlerName;
@property (nonatomic, readonly) NSString* currentCatchHandlerName;
@property (nonatomic, getter = isLaunching) BOOL launching;

@end
