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


- (void)viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];
    
    [self newGame];
}


- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    [self resignFirstResponder];
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
    
    _ball = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 10, self.view.center.y - 10 , 20, 20)]; //,
    
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


////////////////////////////////////////////////////////////////////////////


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_gameIsStart) {
        
        for (UITouch *touch in touches) {
            
            CGPoint point = [touch locationInView:self.view];
            
            if (_bottomTouch == nil && point.y > HALF_SCREEN_HEIGHT) {
                
                _bottomTouch = touch;
                
                _paddleBottom.center = CGPointMake(point.x, point.y);
            } else if (_topTouch == nil && point.y < HALF_SCREEN_HEIGHT) {
                
                _topTouch = touch;
                
                _paddleTop.center = CGPointMake(point.x, point.y);
            }
            
        }
        
    } else {
        
        [self newGame];
    }
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self.view];
        
        if (touch == _topTouch) {
            
            if (point.y > HALF_SCREEN_HEIGHT) {
                
                _paddleTop.center = CGPointMake(point.x, HALF_SCREEN_HEIGHT);
                
                return;
            }
            
            _paddleTop.center = point;
        } else if (touch == _bottomTouch) {
            
            if (point.y < HALF_SCREEN_HEIGHT) {
                
                _paddleBottom.center = CGPointMake(point.x, HALF_SCREEN_HEIGHT);
                
                return;
            }
            
            _paddleBottom.center = point;
        }
        
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        if (touch == _topTouch) {
            
            _topTouch = nil;
        } else if (touch == _bottomTouch) {
            
            _bottomTouch = nil;
        }
        
    }
    
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self touchesEnded:touches withEvent:event];
}


- (void)displayMessage:(NSString *)message {
    
    [self stop];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Да" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self gameOver]) {
            
            [self newGame];
            
            return;
        }
        
        [self reset];
        
        [self start];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Нет" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        self->_gameIsStart = false;
    }];
    
    [alertController addAction:action];
    
    [alertController addAction:actionCancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)newGame {
    
    [self reset];
    
    _scoreTop.text = @"0";
    
    _scoreBottom.text = @"0";
    
    [self displayMessage:@"Готовы к игре?"];
}


- (int)gameOver {
    
    if ([_scoreTop.text intValue] >= MAX_SCORE) return 1;
    
    if ([_scoreBottom.text intValue] >= MAX_SCORE) return 2;
    
    return 0;
}


- (void)start {
    
    _gameIsStart = true;
    
    _ball.center = CGPointMake(HALF_SCREEN_WIDTH, HALF_SCREEN_HEIGHT);
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    }
    
    _ball.hidden = NO;
}


- (void)reset {
    
    if ((arc4random() % 2) == 0) {
        
        _dx = -1;
    } else {
        
        _dx = 1;
    }
    
    if (_dy != 0) {
        
        _dy = -_dy;
    } else if ((arc4random() % 2) == 0) {
        
        _dy = -1;
    } else  {
        
        _dy = 1;
    }
    
    _ball.center = CGPointMake(HALF_SCREEN_WIDTH, HALF_SCREEN_HEIGHT);
    
    _speed = 2;
}


- (void)stop {
    
    if (_timer) {
        
        [_timer invalidate];
        
        _timer = nil;
    }
    
    _ball.hidden = YES;
}


- (void)animate {
    
    _ball.center = CGPointMake(_ball.center.x + _dx*_speed, _ball.center.y + _dy*_speed);
    
    [self checkCollision:CGRectMake(0, 0, 20, SCREEN_HEIGHT) X:fabs(_dx) Y:0];
    
    [self checkCollision:CGRectMake(SCREEN_WIDTH, 0, 20, SCREEN_HEIGHT) X:-fabs(_dx) Y:0];
    
    if ([self checkCollision:_paddleTop.frame X:(_ball.center.x - _paddleTop.center.x) / 32.0 Y:1]) {
    
        [self increaseSpeed];
    }
    
    if ([self checkCollision:_paddleBottom.frame X:(_ball.center.x - _paddleBottom.center.x) / 32.0 Y:-1]) {
    
        [self increaseSpeed];
    }
    
    [self goal];
}


- (void)increaseSpeed {
   
    _speed += 0.5;
    
    if (_speed > 10) _speed = 10;
}


- (BOOL)checkCollision: (CGRect)rect X:(float)x Y:(float)y {

    if (CGRectIntersectsRect(_ball.frame, rect)) {

        if (x != 0) _dx = x;

        if (y != 0) _dy = y;

        return YES;
    }

    return NO;
}


- (BOOL)goal {
    
    if (_ball.center.y < 0 || _ball.center.y >= SCREEN_HEIGHT) {
    
        int s1 = [_scoreTop.text intValue];
        
        int s2 = [_scoreBottom.text intValue];
        
        if (_ball.center.y < 0) ++s2; else ++s1;
        
        _scoreTop.text = [NSString stringWithFormat:@"%u", s1];
        
        _scoreBottom.text = [NSString stringWithFormat:@"%u", s2];
        
        int gameOver = [self gameOver];
        
        if (gameOver) {
        
            [self displayMessage:[NSString stringWithFormat:@"Игрок %i выиграл", gameOver]];
        } else {
            
            [self reset];
        }
        
        return YES;
    }
    
    return NO;
}


@end

