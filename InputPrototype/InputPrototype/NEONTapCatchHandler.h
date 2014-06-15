//
//  NEONTapCatchHandler.h
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-14.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NEONCatchHandler.h"

@interface NEONTapCatchHandler : NSObject<NEONCatchHandler>

+ (instancetype) newWithWithTargetPoint:(CGPoint)target;

- (instancetype) initWithTargetPoint:(CGPoint)target;

@end
