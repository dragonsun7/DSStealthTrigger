//
//  DSStealthTriggerView.m
//  DSStealthTriggerDemo
//
//  Created by Dragon Sun on 2018/8/21.
//  Copyright © 2018 Dragon Sun. All rights reserved.
//

#import "DSStealthTriggerView.h"


@interface DSStealthTriggerView()

@property (nonatomic, assign) CGPoint touchBeganPoint;      // 一次点击开始的坐标
@property (nonatomic, assign) CGPoint touchEndedPoint;      // 一次点击结束的坐标
@property (nonatomic, strong) NSMutableString *tempCode;    // 用户当前输入的序列
@property (nonatomic, strong) NSTimer *timer;               // 计时器，用于处理输入时间限制

@end


@implementation DSStealthTriggerView


#pragma mark - 生命期

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _inputDuration = 8.0f;
    }
    
    return self;
}

- (void)dealloc {
    [self destoryTimer];
}


#pragma mark - 触摸处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];
    self.touchBeganPoint = [touch locationInView:touch.view];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];
    self.touchEndedPoint = [touch locationInView:touch.view];
    [self doTapped];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.touchBeganPoint = CGPointZero;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return [self areaContainsPoint:point] ? hitView : nil;
}


# pragma mark - 绘制

- (void)drawRect:(CGRect)rect {
    if (_showArea && _areas) {
        for (DSTriggerArea *area in _areas) {
            UIColor *color = [UIColor redColor];
            
            // 绘制边线
            [color set];
            UIRectFrame(area.rect);
            
            // 绘制文字
            NSDictionary *attrDict = @{
                                       NSForegroundColorAttributeName: color,
                                       NSFontAttributeName: [UIFont systemFontOfSize:30]
                                       };
            [area.code drawInRect:area.rect withAttributes:attrDict];
        }
    }
}


# pragma mark - 私有方法

/**
 当一次点击完成后进行的处理
 */
- (void)doTapped {
    DSTriggerArea *beganArea = [self areaContainsPoint:_touchBeganPoint];
    DSTriggerArea *endedArea = [self areaContainsPoint:_touchEndedPoint];
    if (beganArea && beganArea == endedArea) {
        if (!_tempCode) {
            [self resetTempCode];
        }
        
        if ([_tempCode isEqualToString:@""]) {
            [self createTimer];
        }
        
        [_tempCode appendString:beganArea.code];
        NSLog(@"%@", _tempCode);
        if ([_code isEqualToString:_tempCode]) {
            [self resetTempCode];
            [self destoryTimer];
            if (_success) {
                _success();
            }
        }
    }
}

/**
 判断指定的坐标是否有对应的触发区域

 @param point 坐标
 @return 触发区域，如果没有则返回nil
 */
- (nullable DSTriggerArea *)areaContainsPoint:(CGPoint)point {
    for (DSTriggerArea *area in _areas) {
        if (CGRectContainsPoint(area.rect, point)) {
            return area;
        }
    }
    
    return nil;
}


/**
 重置用户输入的序列
 */
- (void)resetTempCode {
    _tempCode = [NSMutableString string];
}

- (void)createTimer {
    [self destoryTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_inputDuration repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self resetTempCode];
    }];
}

- (void)destoryTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
