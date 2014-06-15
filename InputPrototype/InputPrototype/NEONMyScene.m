//
//  NEONMyScene.m
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-7.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import "NEONMyScene.h"

#import "NEONSlingshotInputHandler.h"
#import "NEONLauncherInputHandler.h"

#import "NEONTapCatchHandler.h"
#import "NEONTapInAreaCatchHandler.h"
#import "NEONTapOnWBCatchHandler.h"

@interface NEONMyScene ()

@property (nonatomic) NSArray* launchHandlers;
@property (nonatomic) NSArray* catchHandlers;
@property (nonatomic) NSUInteger launchHandlerIndex;
@property (nonatomic) NSUInteger catchHandlerIndex;
@property (nonatomic) id<NEONLaunchHandler> launchHandler;
@property (nonatomic) id<NEONCatchHandler> catchHandler;
@property (nonatomic) SKSpriteNode* waterBalloon;
@property (nonatomic) CGPoint startPosition;

@end

@implementation NEONMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [self setLaunchHandlers:@[ [NEONLauncherInputHandler new], [NEONSlingshotInputHandler new] ]];
        [self setLaunchHandlerIndex:0];
        [self setLaunchHandler:[self launchHandlers][[self launchHandlerIndex]]];

        CGPoint targetPoint = CGPointMake(size.width * (3.0f/4.0f), size.height / 3.0f);

        [self setCatchHandlers:@[ [NEONTapInAreaCatchHandler newWithWithTargetPoint:targetPoint ], [NEONTapCatchHandler newWithWithTargetPoint:targetPoint], [NEONTapOnWBCatchHandler newWithWithTargetPoint:targetPoint] ]];
        [self setCatchHandlerIndex:0];
        [self setCatchHandler:[self catchHandlers][[self catchHandlerIndex]]];

        SKSpriteNode* hitArea = [[SKSpriteNode alloc] initWithImageNamed:@"HitArea"];
        [hitArea setName:@"HitArea"];
        [hitArea setSize:CGSizeMake([[self catchHandler] thresholdDistance] * 2, [[self catchHandler] thresholdDistance] * 2)];
        [hitArea setAlpha:0.4];

        SKSpriteNode* target = [[SKSpriteNode alloc] initWithImageNamed:@"Bullseye"];
        [target setName:@"Bullseye"];
        [self addChild:target];
        [target addChild:hitArea];
        [target setSize:CGSizeMake(32, 32)];
        [target setPosition:targetPoint];

        SKSpriteNode* wb = [[SKSpriteNode alloc] initWithImageNamed:@"WaterBalloon"];
        [self addChild:wb];
        [wb setSize:CGSizeMake(32, 32)];
        [wb setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:32]];
        [[wb physicsBody] setAffectedByGravity:NO];
        [[wb physicsBody] setMass:1];
        CGPoint position = CGPointMake(size.width / 4.0f, size.height / 3.0f);
        [self setStartPosition:position];
        [self setWaterBalloon:wb];

        [[self physicsWorld] setGravity:CGVectorMake(0, -4.9)];

        [self reset];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isLaunching])
    {
        [[self launchHandler] touchesBegan:touches
                                withSprite:[self waterBalloon]
                                  andScene:self];
    }
    else
    {
        [[self catchHandler] touchesBegan:touches
                               withSprite:[self waterBalloon]
                                 andScene:self];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isLaunching])
    {
        [[self launchHandler] touchesMoved:touches
                                withSprite:[self waterBalloon]
                                  andScene:self];
    }
    else
    {
        [[self catchHandler] touchesMoved:touches
                               withSprite:[self waterBalloon]
                                 andScene:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isLaunching])
    {
        [[self launchHandler] touchesEnded:touches
                                withSprite:[self waterBalloon]
                                  andScene:self];
    }
    else
    {
        [[self catchHandler] touchesEnded:touches
                               withSprite:[self waterBalloon]
                                 andScene:self];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void) reset
{
    [[self waterBalloon] setPosition:[self startPosition]];
    [[[self waterBalloon] physicsBody] setAffectedByGravity:NO];
    [[[self waterBalloon] physicsBody] setVelocity:CGVectorMake(0, 0)];
    [self setLaunching:YES];
}

- (void) nextLaunchHandler
{
    NSUInteger next = ([self launchHandlerIndex] + 1) % [[self launchHandlers] count];
    [self setLaunchHandlerIndex:next];
    [self setLaunchHandler:[self launchHandlers][next]];
}

- (NSString*) currentLaunchHandlerName
{
    return [[self launchHandler] name];
}

- (void) nextCatchHandler
{
    NSUInteger next = ([self catchHandlerIndex] + 1) % [[self catchHandlers] count];
    [self setCatchHandlerIndex:next];
    [self setCatchHandler:[self catchHandlers][next]];
    SKSpriteNode* ha = (SKSpriteNode*)[[self childNodeWithName:@"Bullseye"] childNodeWithName:@"HitArea"];
    [ha setSize:CGSizeMake([[self catchHandler] thresholdDistance] * 2, [[self catchHandler] thresholdDistance] * 2)];
}

- (NSString*) currentCatchHandlerName
{
    return [[self catchHandler] name];
}

- (void) setLaunching:(BOOL)launching
{
    _launching = launching;
    SKNode* ha = [[self childNodeWithName:@"Bullseye"] childNodeWithName:@"HitArea"];
    [ha setHidden:_launching];
}

@end
