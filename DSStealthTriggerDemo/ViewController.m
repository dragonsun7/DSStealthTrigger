//
//  ViewController.m
//  DSStealthTriggerDemo
//
//  Created by Dragon Sun on 2018/8/21.
//  Copyright © 2018 Dragon Sun. All rights reserved.
//

#import "ViewController.h"
#import "DSStealthTriggerView.h"


@interface ViewController ()

@property (nonatomic, strong) DSStealthTriggerView *stView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat side = 80.0f;
    CGFloat x = self.view.bounds.size.width - side;
    CGFloat y = self.view.bounds.size.height - side;
    
    // 定义了两块区域
    DSTriggerArea *ta1 = [[DSTriggerArea alloc] init];
    ta1.code = @"A";
    ta1.rect = CGRectMake(0, y, side, side);
    DSTriggerArea *ta2 = [[DSTriggerArea alloc] init];
    ta2.code = @"B";
    ta2.rect = CGRectMake(x, y, side, side);

    // 将DSStealthTriggerView添加到当前视图
    _stView = [[DSStealthTriggerView alloc] initWithFrame:self.view.bounds];
    _stView.areas = @[ta1, ta2];
    _stView.code = @"ABABAABA";
    _stView.inputDuration = 8.0f;
    _stView.showArea = YES;
    _stView.backgroundColor = [UIColor clearColor];
    _stView.success = ^{
        NSLog(@"success");
    };
    
    [self.view addSubview:_stView];
    self.label.text = _stView.code;
}

@end
