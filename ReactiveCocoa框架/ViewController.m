//
//  ViewController.m
//  ReactiveCocoa框架
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

#import "ReactiveCocoa.h"

#import "RedView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RedView *redV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 订阅信号
    [_redV.btnClickSignal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
}

- (void)test
{
    // Do any additional setup after loading the view, typically from a nib.
    // 只要想先发送信号,再去订阅就使用RACReplaySubject
    /*******RACReplaySubject*************/
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    [replaySubject sendNext:@1];
    // 把值保存起来,遍历所有的订阅者发送数据
    
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"replaySubject%@",x);
    }];
    // 遍历所有的值,拿到订阅者发送数据
    
    
    
    /*******RACSubject*************/
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 3.发送信号
    [subject sendNext:@1];
    // * 遍历所有订阅者发送信号
    
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    // 保存订阅者
}

- (void)RACReplaySubject
{
    // RACReplaySubject:允许先发送信号,在订阅信号
    
    
    // 重复信号提供者
    // 1.创建信号
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    // 2.发送信号
    [subject sendNext:@"123123"];
    [subject sendNext:@"345"];
    [subject sendNext:@"456456"];
    // 1.把值保存到数组
    // 2.遍历所有的订阅者,调用nextBlock
    
    // 3.订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者一%@",x);
    }];
    // 1.遍历所有值,拿到订阅者去发送
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者二%@",x);
    }];
    
    
    
    
    /*
     执行流程:
     1.创建信号
     2.订阅信号
     * 创建订阅者,保存nextBlock保存
     * 遍历valuesReceived需要发送的所有值,拿到一个一个值,利用订阅者发送数据
     3.发送信号
     * 把发送的值,保存到数组
     * 把所有的订阅者遍历出来,一个一个的调用它们nextBlock
     */

}

- (void)RACSubject
{
    // 信号提供者:既可以充当信号,也可以充当订阅者,发送数据
    // 一个信号允许被多次订阅
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        
        NSLog(@"订阅者一%@",x);
    }];
    
    [subject subscribeNext:^(id x) {
        
        NSLog(@"订阅者二%@",x);
    }];
    
    
    // 3.发送信号
    [subject sendNext:@1];
    
    /*
     执行流程:
     1.创建信号
     2.订阅信号
     * 创建订阅者
     * [self subscribe:o]订阅信号,仅仅是把订阅者保存起来.
     3.发送信号
     * 把所有的订阅者遍历出来,一个一个的调用它们nextBlock
     */

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
