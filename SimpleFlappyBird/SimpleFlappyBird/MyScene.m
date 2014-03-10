//
//  MyScene.m
//  SimpleFlappyBird
//
//  Created by Ashish Chandwani on 3/10/14.
//  Copyright (c) 2014 Ashish Chandwani. All rights reserved.
//

#import "MyScene.h"
const float SKYLINE_MOVEMENT_SCALE = 0.01;
const float GROUND_MOVEMENT_SCALE = 0.02;

@interface MyScene() {
    SKSpriteNode* _bird;
    SKColor* _skyColor;
}
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        // Setup sky
        _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        [self setBackgroundColor:_skyColor];
        
        // Create ground
        SKTexture* groundTexture = [SKTexture textureWithImageNamed:@"Ground"];
        groundTexture.filteringMode = SKTextureFilteringNearest;
        
        // Ground animation for movement
        SKAction* moveGroundSprite = [SKAction moveByX:-groundTexture.size.width*2 y:0 duration:GROUND_MOVEMENT_SCALE * groundTexture.size.width*2];
        SKAction* resetGroundSprite = [SKAction moveByX:groundTexture.size.width*2 y:0 duration:0]; // instantly reset position
        SKAction* moveGroundSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
        
        for (int i = 0; i < 2 + self.frame.size.width / (groundTexture.size.width * 2); ++i) {

            // Add some ground sprites
            SKSpriteNode* groundSprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
            [groundSprite setScale:2.0];
            groundSprite.position = CGPointMake(i * groundSprite.size.width, groundSprite.size.height / 2);
            [groundSprite runAction:moveGroundSpritesForever];
            [self addChild:groundSprite];
        }
        
        // Create skyline
        SKTexture* skylineTexture = [SKTexture textureWithImageNamed:@"Skyline"];
        skylineTexture.filteringMode = SKTextureFilteringNearest;
        
        // Skyline animation for movement (different scale for parallax effect)
        SKAction* moveSkylineSprite = [SKAction moveByX:-skylineTexture.size.width*2 y:0 duration:SKYLINE_MOVEMENT_SCALE * skylineTexture.size.width*2];
        SKAction* resetSkylineSprite = [SKAction moveByX:skylineTexture.size.width*2 y:0 duration:0]; // instantly reset position
        SKAction* moveSkylineSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkylineSprite, resetSkylineSprite]]];

        
        for (int i = 0; i < 2 + self.frame.size.width / (groundTexture.size.width * 2); ++i) {
            SKSpriteNode* skylineSprite = [SKSpriteNode spriteNodeWithTexture:skylineTexture];
            [skylineSprite setScale:2.0];
            skylineSprite.zPosition = -20;
            skylineSprite.position = CGPointMake(i * skylineSprite.size.width, skylineSprite.size.height / 2 + groundTexture.size.height * 2);
            [skylineSprite runAction:moveSkylineSpritesForever];
            [self addChild:skylineSprite];
        }
        
        // Setup bird
        SKTexture* birdTexture1 = [SKTexture textureWithImageNamed:@"Bird1"];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        SKTexture* birdTexture2 = [SKTexture textureWithImageNamed:@"Bird2"];
        birdTexture2.filteringMode = SKTextureFilteringNearest;
        
        // Cycle through the two flapping images forever
        SKAction* flap = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture1, birdTexture2] timePerFrame:0.2]];
        _bird = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
        [_bird setScale:2.0];
        _bird.position = CGPointMake(self.frame.size.width / 4, CGRectGetMidY(self.frame));
        [_bird runAction:flap];
        [self addChild:_bird];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
