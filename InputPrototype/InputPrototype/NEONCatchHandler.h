//
//  NEONCatchHandler.h
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-14.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@protocol NEONCatchHandler <NSObject>

-(void)touchesBegan:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene;
-(void)touchesMoved:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene;
-(void)touchesEnded:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene;

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) CGFloat thresholdDistance;

@end
