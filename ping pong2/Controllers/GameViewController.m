//
//  GameViewController.m
//  ping pong2
//
//  Created by Марат Нургалиев on 09/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end


@implementation GameViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self config];
}


- (void)config {
    
    [self configBackground];
    
    [self configGrid];
    
    [self configPaddles];
    
    [self configBall];
    
    [self configScore];
}


- (void)configBackground {
    
    UIColor *color = [UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0];
    
    self.view.backgroundColor = color;
}


- (void)configGrid {
    
    _gridView = [[UIView alloc] initWithFrame:CGRectMake(0, HALF_SCREEN_HEIGHT - 2, SCREEN_WIDTH, 4)];
    
    _gridView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    [self.view addSubview:_gridView];
}


- (void)configPaddles {
    
    _paddleTop = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, 90, 60)];
    
    _paddleTop.image = [UIImage imageNamed:@"paddleTop"];
    
    _paddleTop.contentMode = UIViewContentModeScaleAspectFit;
    
    _paddleTop.tintColor = [UIColor redColor];
    
    [self.view addSubview:_paddleTop];
    
    
    _paddleBottom = [[UIImageView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 90, 90, 60)];
    
    _paddleBottom.image = [UIImage imageNamed:@"paddleBottom"];
    
    _paddleBottom.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:_paddleBottom];
}


- (void)configBall {
    
    _ball = [[UIView alloc] initWithFrame:CGRectMake(120, SCREEN_HEIGHT - 90 , 20, 20)]; //self.view.center.x - 10, self.view.center.y - 10
    
    _ball.backgroundColor = [UIColor whiteColor];
    
    _ball.layer.cornerRadius = 10;
    
    //    _ball.hidden = YES;
    
    [self.view addSubview:_ball];
}

- (void)configScore {
    
    _scoreTop = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, HALF_SCREEN_HEIGHT - 70, 50, 50)];
    
    _scoreTop.textColor = [UIColor whiteColor];
    
    _scoreTop.text = @"0";
    
    _scoreTop.font = [UIFont systemFontOfSize:40.0 weight: UIFontWeightLight];
    
    _scoreTop.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_scoreTop];
    
    
    _scoreBottom = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, HALF_SCREEN_HEIGHT + 20, 50, 50)];
    
    _scoreBottom.textColor = [UIColor whiteColor];
    
    _scoreBottom.text = @"0";
    
    _scoreBottom.font = [UIFont systemFontOfSize:40.0 weight: UIFontWeightLight];
    
    _scoreBottom.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_scoreBottom];
}


@end

