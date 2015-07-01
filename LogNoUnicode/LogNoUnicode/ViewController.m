//
//  ViewController.m
//  LogNoUnicode
//
//  Created by Cocoa Lee on 15/7/1.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSDictionary *dic = @{@"name":@"孙悟空",@"age":@"500",@"talk":@"妖怪被师傅抓走了"};
    
    NSLog(@"dic :%@",dic);
    
    [self logNoUnicode:dic withDescription:@"信息"];
    
    }

-(void)logNoUnicode:(NSDictionary *)dic  withDescription:(NSString*)description
{
    //    NSLog(@"dic : %@",dic);
    NSString *stepOne = [dic description];
    //把"替换成\"
    NSString *stepTwo = [stepOne stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    //string2 首位加上"
    NSString *stepThree = [[@"\"" stringByAppendingString:stepTwo] stringByAppendingString:@"\""];
    NSData *tempData = [stepThree dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    NSLog(@"%@ :%@",description,str);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
