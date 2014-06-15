//
//  NEONLauncherInputHandler.m
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-14.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import "NEONLauncherInputHandler.h"

#import "NEONMyScene.h"

static const float s_Mod = 2.0f;

@interface NEONLauncherInputHandler ()

@property (nonatomic) CGPoint startPoint;

@end

@implementation NEONLauncherInputHandler

- (NSString*) name
{
    return @"Launcher";
}

-(void)touchesBegan:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(NEONMyScene*)scene
{
    if ([touches count] == 1)
    {
        UITouch* touch = (UITouch*)[touches anyObject];
        [self setStartPoint:[touch locationInNode:scene]];
    }
}

-(void)touchesMoved:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(NEONMyScene*)scene
{

}

-(void)touchesEnded:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(NEONMyScene*)scene
{
    if ([touches count] == 1)
    {
        UITouch* touch = (UITouch*)[touches anyObject];
        CGPoint location = [touch locationInNode:scene];
        CGVector distance = CGVectorMake((location.x - [self startPoint].x) * s_Mod, (location.y - [self startPoint].y) * s_Mod);
        [[balloon physicsBody] applyImpulse:distance];
        [[balloon physicsBody] setAffectedByGravity:YES];

        [scene setLaunching:NO];
    }
}

@end
