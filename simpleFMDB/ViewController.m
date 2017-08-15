//
//  ViewController.m
//  simpleFMDB
//
//  Created by 胡高广 on 2017/8/15.
//  Copyright © 2017年 胡高广. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "TwoViewController.h"
@interface ViewController ()

@property (nonatomic, strong) FMDatabase *db;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据库";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //按钮
    UIButton *openBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    openBtn.frame = CGRectMake(100, 100, 50, 20);
    openBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [openBtn setTitle:@"创建" forState:(UIControlStateNormal)];
    openBtn.backgroundColor = [UIColor greenColor];
    [openBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [openBtn addTarget:self action:@selector(openBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:openBtn];
    
    //增加
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addBtn.frame = CGRectMake(100, CGRectGetMaxY(openBtn.frame) + 30, 50, 20);
    addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addBtn setTitle:@"增加" forState:(UIControlStateNormal)];
    addBtn.backgroundColor = [UIColor yellowColor];
    [addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addBtn];
    
    //查询
    UIButton *lookBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lookBtn.frame = CGRectMake(100, CGRectGetMaxY(addBtn.frame) + 30, 50, 20);
    lookBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [lookBtn setTitle:@"查询" forState:(UIControlStateNormal)];
    lookBtn.backgroundColor = [UIColor blueColor];
    [lookBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [lookBtn addTarget:self action:@selector(lookBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:lookBtn];
    
    //删除
    UIButton *cutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cutBtn.frame = CGRectMake(100, CGRectGetMaxY(lookBtn.frame) + 30, 50, 20);
    cutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cutBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    cutBtn.backgroundColor = [UIColor redColor];
    [cutBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [cutBtn addTarget:self action:@selector(cutBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:cutBtn];
    
    //更改
    UIButton *gaiButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    gaiButton.frame = CGRectMake(100, CGRectGetMaxY(cutBtn.frame) + 30, 50, 20);
    gaiButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [gaiButton setTitle:@"更改" forState:(UIControlStateNormal)];
    gaiButton.backgroundColor = [UIColor redColor];
    [gaiButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [gaiButton addTarget:self action:@selector(gauBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:gaiButton];
    
    //点击
    UIButton *clickButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    clickButton.frame = CGRectMake(100, CGRectGetMaxY(gaiButton.frame) + 30, 50, 20);
    clickButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [clickButton setTitle:@"点击" forState:(UIControlStateNormal)];
    clickButton.backgroundColor = [UIColor redColor];
    [clickButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [clickButton addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:clickButton];
    
    //获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"operDB.sqlite"];
    
    //得到数据库
    self.db = [FMDatabase databaseWithPath:filename];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -- 打开数据库
-(void)openBtn:(UIButton *)sender
{
    //打开数据库
    if([self.db open]){
        NSLog(@"打开数据库成功");
        //创建
        BOOL result = [self.db executeUpdate:@"create table if not exists student(id integer primary key autoincrement,name text,age integer);"];
        if(result){
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
        [self.db close];
        
    }else{
        NSLog(@"打开数据库失败");
    }
}
#pragma mark -- 增加数据
-(void)addBtn:(UIButton *)sender
{
    if([self.db open]){
        NSString *name = @"小红";
        BOOL result =[self.db executeUpdate:@"insert into student (name,age) values (?,?);",name,@(20)];
        if(result){
            NSLog(@"插入数据成功");
        }
    }
}
#pragma mark -- 查询数据
-(void)lookBtn:(UIButton *)sender
{
    if([self.db open]){
        NSString *sql = @"select * from student";
        FMResultSet *rs = [self.db executeQuery:sql];
        while ([rs next]) {
            NSString *nameStr = [rs stringForColumn:@"name"];
            int ageStr = [rs intForColumn:@"age"];
            NSLog(@"这位同学的姓名--%@,今年%d岁",nameStr,ageStr);
        }
        
        [self.db close];
    }
}
#pragma mark -- 删除数据
-(void)cutBtn:(UIButton *)sender
{
    if([self.db open]){
        //清空
        NSString *deleteSql = @"DELETE FROM student";
        [self.db executeUpdate:@"UPDATE sqlite_sequence set seq = 0 where name = 'student'"];
        BOOL res = [self.db executeUpdate:deleteSql];
        if(res){
            NSLog(@"清空数据成功");
        }else{
            NSLog(@"清空数据失败");
        }
        [self.db close];
    }
}
#pragma mark -- 更改数据
-(void)gauBtn:(UIButton *)sender
{
    NSLog(@"更改数据");
}
#pragma mark -- 点击跳转
-(void)clickButton:(UIButton *)sender
{
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
