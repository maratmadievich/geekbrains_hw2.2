//
//  GameViewController.h
//  ping pong2
//
//  Created by Марат Нургалиев on 09/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define HALF_SCREEN_WIDTH SCREEN_WIDTH/2

#define HALF_SCREEN_HEIGHT SCREEN_HEIGHT/2

#define MAX_SCORE 6


@property (strong, nonatomic) UIImageView *paddleTop;

@property (strong, nonatomic) UIImageView *paddleBottom;

@property (strong, nonatomic) UIView *gridView;

@property (strong, nonatomic) UIView *ball;

@property (strong, nonatomic) UITouch *topTouch;

@property (strong, nonatomic) UITouch *bottomTouch;

@property (strong, nonatomic) NSTimer * timer;

@property (nonatomic) float dx;

@property (nonatomic) float dy;

@property (nonatomic) float speed;

@property (strong, nonatomic) UILabel *scoreTop;

@property (strong, nonatomic) UILabel *scoreBottom;

@end
