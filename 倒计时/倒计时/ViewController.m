//
//  ViewController.m
//  倒计时
//
//  Created by 杨应海 on 16/8/16.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/**
 *   显示时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 天数 */
@property (nonatomic, assign) NSInteger day;
/** 小时 */
@property (nonatomic, assign) NSInteger hour;
/** 分钟 */
@property (nonatomic, assign) NSInteger minute;
/** 秒 */
@property (nonatomic, assign) NSInteger second;
/** 百分秒 */
@property (nonatomic, assign) NSInteger perSecond;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  传两天时间，数据初始化
     */
    
    
    _day = 2;
    _hour = 0;
    _minute = 0;
    _second = 0;
    _perSecond = 0;
    
    [self calulateTime:_day];
}

/**
 *  计算倒计时
 */
- (void)calulateTime:(NSInteger)day {
    
    /**
        这里注意，最后一位是百分秒，所以时钟调用时间时间间隔  1 / 100 s
     */
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 / 100.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)updateTimer {
    
    /**
     *  1、首先让百分秒 -1
        2、然后根据判断条件，下面的 if 条件都会走一遍
            目的-->这样可以把初始数据显示在上面，同时设置进率
        3、根据显示的 再然后 每一个 属性都会在自己完成一轮进率之后 又进入判断 以此类推 循环递减
     */
    
    
     _perSecond --;
    
    /** 每次百分秒为 0 的时候进入判断 */
    if (_perSecond == -1) {
        _second --;
        _perSecond = 100;
    }
   
    
    /** 在判断百分秒为 0 的情况，秒减了 1 ===> 目的是为了设置初始值 */
    if (_second == -1) {
        _minute --;
        _second = 59; // 此时设置为 59 秒之后 ，在上面一个 if 中 走完直到为 -1，才会是进入这个 if，下面的判断一次类推
    }
    
    /** 判断秒为 -1 时，分减了 1 */
    if (_minute == -1) {
        _hour --;
        _minute = 59;
    }
    
    
    if (_hour == -1) {
        _day --;
        _hour = 23;
    }
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%02zd天-%02zd时- %02zd:%02zd:%02zd",_day,_hour,_minute,_second,_perSecond];
    
}









@end





