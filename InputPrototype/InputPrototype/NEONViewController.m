//
//  NEONViewController.m
//  InputPrototype
//
//  Created by Kyle Roucis on 14-6-7.
//  Copyright (c) 2014 Neon Games. All rights reserved.
//

#import "NEONViewController.h"
#import "NEONMyScene.h"

@interface NEONViewController ()

- (IBAction) reset:(id)sender;
- (IBAction) nextLaunchHandler:(id)sender;
- (IBAction) nextCatchHandler:(id)sender;

@property (nonatomic, weak) IBOutlet UILabel* launchNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* catchNameLabel;
@property (nonatomic) NEONMyScene* scene;

@end

@implementation NEONViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    NEONMyScene * scene = [NEONMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];

    [[self launchNameLabel] setText:[scene currentLaunchHandlerName]];
    [[self catchNameLabel] setText:[scene currentCatchHandlerName]];
    [self setScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction) reset:(id)sender
{
    [[self scene] reset];
}

- (IBAction) nextLaunchHandler:(id)sender
{
    [[self scene] nextLaunchHandler];
    [[self launchNameLabel] setText:[[self scene] currentLaunchHandlerName]];
}

- (IBAction) nextCatchHandler:(id)sender
{
    [[self scene] nextCatchHandler];
    [[self catchNameLabel] setText:[[self scene] currentCatchHandlerName]];
}

@end
