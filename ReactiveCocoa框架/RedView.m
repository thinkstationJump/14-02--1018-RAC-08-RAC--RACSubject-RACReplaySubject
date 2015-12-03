//
//  RedView.m
//  ReactiveCocoa框架
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (RACSubject *)btnClickSignal
{
    if (_btnClickSignal == nil) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

- (IBAction)btnClick:(id)sender
{
    NSLog(@"按钮点击");
    
    [self.btnClickSignal sendNext:@"我的按钮被点击"];
    
}

@end
