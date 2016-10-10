//
//  ViewController.m
//  PathFunc
//
//  Created by 李财 on 16/10/10.
//  Copyright © 2016年 李财. All rights reserved.
//
/**
 *  获取沙盒路径及Document Library Temp 路径的操作 增删  NSData数据类型的准换 NSData
 *  转图片 转字符串
 *  文件操作函数：NSFileHandle类  主要对文件内容进行读取和写入操作
 *  NSFileManager类 主要对文件的操作 删除创建等等
 *  将图片存入本地  判断传入的文件路径是否存在
 
 *  @param void <#void description#>
 *
 *  @return <#return value description#>
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取沙盒路径
 //   [self getHomePath];
    
   //获取Doucument
//    [self getDoucumentPath];
    
//    [self getLibraryPath];
    
//    [self parsePath];
    
//    [self createFolder];
    
//    [self createFile];
//    [self writeFile];
//    [self addFile];
//    [self deleteFile];
    [self writeImage];
}

//获取沙盒路径的函数
- (NSString *)getHomePath{

    NSString * homePath = NSHomeDirectory();
    
    NSLog(@"%@",homePath);

    return homePath;
}
//获取Doucument的函数
- (NSString *)getDoucumentPath{
//在计算机中检索指定路径  参数一：写一个指定目标文件夹 参数二：限定了文件检索范围只在沙箱的内部 参数三：YES 指定有无波浪号
    NSArray * dcoPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES);

    NSString * documentPath = [dcoPaths firstObject];
    NSLog(@"%@",documentPath);
    return documentPath;
}

//获取library的path
//获取Doucument的函数
- (NSString *)getLibraryPath{
    //在计算机中检索指定路径  参数一：写一个指定目标文件夹 参数二：限定了文件检索范围只在沙箱的内部 参数三：YES 指定有无波浪号
    NSArray * libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask , YES);
    
    NSString * libraryPath = [libPaths firstObject];
    NSLog(@"%@",libraryPath);
    return libraryPath;
}

//处理路径
- (void)parsePath{

NSString * path = @"/data/Containers/Data/Application/test.png";
//获得路径的各个组成部分
    NSArray * array = [path pathComponents];
               
    NSLog(@"%@",array);
    
    //提取路径的最后一个组成部分
    NSString * name = [path lastPathComponent];
    NSLog(@"%@",name);
    //删除路径的最后一个组成部分
    NSString * deleteName = [path stringByDeletingLastPathComponent];
    
    NSLog(@"%@",deleteName);
    //追加一个名字 licai
    
    NSString * addStr = [deleteName stringByAppendingPathComponent:@"licai"];
    
    NSLog(@"%@",addStr);
    
    
}

//将传入的二进制文件转换为字符串
- (void)dataChange:(NSData *)data{

   //NSData -> NSString
    NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
   // NSString -> NSData
    NSData * data1 = [string dataUsingEncoding:NSUTF8StringEncoding];

   //NSData -> UIImage
    UIImage * image = [UIImage imageWithData:data];
   //UIImage -> NSData
    NSData * iamgeData = UIImagePNGRepresentation(image);
    
}

//创建文件夹
- (void)createFolder{

//获取目录 写在Document下面
    NSString * path = [self getDoucumentPath];
//在Document下面进行一个拼接
    NSString * testPath = [path stringByAppendingPathComponent:@"诶我去"];
    
    NSFileManager * manager = [NSFileManager defaultManager];//单利
    
    //1：testPath 2：指定的文件夹存在了怎么办 yes表示覆盖 3 4: nil
   BOOL ret = [manager createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (ret) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
}

//在文件夹中创建文件
- (void)createFile{
    NSString * stringPath = [self getDoucumentPath];

    NSString * testPath = [stringPath stringByAppendingPathComponent:@"诶我去"];
    NSString * path = [testPath stringByAppendingPathComponent:@"我的笔记.txt"];
    NSFileManager * manager = [NSFileManager defaultManager];
    
  BOOL ret = [manager createFileAtPath:path contents:nil attributes:nil];
    
    if (ret) {
        NSLog(@"success");
    }else{
        NSLog(@"file");
    }
    
}
//写入文件的操作
- (void)writeFile{
//获取文件在哪里
    NSString * stringPath = [self getDoucumentPath];
    
    NSString * testPath = [stringPath stringByAppendingPathComponent:@"诶我去"];
    NSString * path = [testPath stringByAppendingPathComponent:@"我的笔记.txt"];
    NSString * content = @"测试写笔记";
    
 BOOL ret = [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (ret) {
        NSLog(@"success");
    }else{
    
        NSLog(@"file");
    }
}

//检测文件是否存在  我们提供一个文件路径 检测路径下是否有文件
- (BOOL)fileExist:(NSString *)filePath{

    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        
        return YES;
    }
    return NO;
}
//我们建个文件  又写入了内容 想在文件后面追加一些内容
- (void)addFile{

    NSString * stringPath = [self getDoucumentPath];
    
    NSString * testPath = [stringPath stringByAppendingPathComponent:@"诶我去"];
    NSString * path = [testPath stringByAppendingPathComponent:@"我的笔记.txt"];
    //这个函数的意思是打开文件准备更新
    NSFileHandle * fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    [fileHandle seekToEndOfFile]; //将节点跳到文件的末尾
    NSString * string = @"这是我要加上去的内容";
    NSData * stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileHandle writeData:stringData];
    [fileHandle closeFile]; //关闭文件 安全操作
}

//文件删除操作 要对文件进行操作 首先我们要对文件进行检测是否存在
- (void)deleteFile{

    NSString * stringPath = [self getDoucumentPath];
    
    NSString * testPath = [stringPath stringByAppendingPathComponent:@"诶我去"];
    NSString * path = [testPath stringByAppendingPathComponent:@"我的笔记.txt"];
    NSFileManager * manager = [NSFileManager defaultManager];

    BOOL ret = [self fileExist:path];
    
    if (ret) {
        
      BOOL ret1 = [manager removeItemAtPath:path error:nil];
        
        if (ret1) {
            NSLog(@"文件删除成功");
        }else{
            NSLog(@"文件删除失败");
        }
    }else{
    
        NSLog(@"没有找到文件！");
    }
}


//实例操作  将获取到的图片文件写入本地 并 展示
- (void)writeImage{

    UIImage * image = [UIImage imageNamed:@"屏幕快照"];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    NSString * docPath = [self getDoucumentPath];
    
    NSString * textPath = [docPath stringByAppendingPathComponent:@"诶我去"];
    
    NSString * name = [textPath stringByAppendingPathComponent:@"屏幕截图"];
    
    [data writeToFile:name atomically:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
