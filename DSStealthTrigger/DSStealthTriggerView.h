//
//  DSStealthTriggerView.h
//  DSStealthTriggerDemo
//
//  Created by Dragon Sun on 2018/8/21.
//  Copyright © 2018 Dragon Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSTriggerArea.h"


@interface DSStealthTriggerView : UIView

@property (nonatomic, strong, nullable) NSArray<DSTriggerArea *> *areas;    // 输入区域对象列表(默认nil)
@property (nonatomic, copy, nullable) NSString *code;                       // 输入序列(默认nil)
@property (nonatomic, assign) CGFloat inputDuration;                        // 输入时间限制(默认8秒)
@property (nonatomic, assign) Boolean showArea;                             // 是否显示区域边框(默认NO，用于调试)
@property (nonatomic, copy, nullable) void (^success)(void);                // 验证成功后的回调(默认nil)

@end
