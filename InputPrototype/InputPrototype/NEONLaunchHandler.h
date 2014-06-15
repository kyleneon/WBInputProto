//
//  NEONInputHandler.h
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-7.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@protocol NEONLaunchHandler <NSObject>

-(void)touchesBegan:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene;
-(void)touchesMoved:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene;
-(void)touchesEnded:(NSSet *)touches withSprite:(SKSpriteNode *)balloon  andScene:(SKScene*)scene;

@property (nonatomic, readonly) NSString* name;

@end
