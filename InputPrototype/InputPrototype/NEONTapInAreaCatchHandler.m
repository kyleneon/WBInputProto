//
//  NEONTapInAreaCatchHandler.m
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-14.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import "NEONTapInAreaCatchHandler.h"

static const float s_Distance = 80.0f;

@implementation NEONTapInAreaCatchHandler
{
    CGPoint _target;
}

+ (instancetype) newWithWithTargetPoint:(CGPoint)target
{
    return [[self alloc] initWithTargetPoint:target];
}

- (instancetype) initWithTargetPoint:(CGPoint)target
{
    self = [super init];
    if (self)
    {
        _target = target;
    }

    return self;
}

- (NSString*) name
{
    return @"In Area Tap";
}

-(void)touchesBegan:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene
{

}

-(void)touchesMoved:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene
{

}

-(void)touchesEnded:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene
{
    if ([touches count] == 1)
    {
        CGPoint touch = [[touches anyObject] locationInNode:scene];
        CGVector distance = CGVectorMake(_target.x - touch.x, _target.y - touch.y);
        CGFloat dist = sqrtf((distance.dx * distance.dx) + (distance.dy * distance.dy));
        if (dist - s_Distance <= 0.0)
        {
            CGPoint position = [balloon position];
            distance = CGVectorMake(_target.x - position.x, _target.y - position.y);
            dist = sqrtf((distance.dx * distance.dx) + (distance.dy * distance.dy));
            if (dist - s_Distance <= 0.0)
            {
                [[balloon physicsBody] setVelocity:CGVectorMake(0, 0)];
                [[balloon physicsBody] setAffectedByGravity:NO];
            }
        }

    }
}

- (CGFloat) thresholdDistance
{
    return s_Distance;
}

@end
