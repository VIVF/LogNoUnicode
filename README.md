# LogNoUnicode
LogNoUnicode
我们在调试程序的时候输出的Log信息经常是这样的：

```
2015-07-01 23:37:55.141 LogNoUnicode[1737:69936] dic :{
    age = 500;
    name = "\U5b59\U609f\U7a7a";
    talk = "\U5996\U602a\U88ab\U5e08\U5085\U6293\U8d70\U4e86";
}
```
这是为什么呢？

###原因

####[Unicode 原理](https://zh.wikipedia.org/wiki/Unicode#.E7.BC.96.E7.A0.81.E6.96.B9.E5.BC.8F) 
###解决方法
```
[self logNoUnicode:dic withDescription:@"信息"];



-(void)logNoUnicode:(NSDictionary *)dic  withDescription:(NSString*)description
{
    NSString *stepOne = [dic description];
    NSString *stepTwo = [stepOne stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *stepThree = [[@"\"" stringByAppendingString:stepTwo] stringByAppendingString:@"\""];
    NSData *tempData = [stepThree dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    NSLog(@"%@ :%@",description,str);
}
```
###输出结果
```
2015-07-01 23:58:28.339 LogNoUnicode[1984:83978] 信息 :{
    age = 500;
    name = "孙悟空";
    talk = "妖怪被师傅抓走了";
}
```


