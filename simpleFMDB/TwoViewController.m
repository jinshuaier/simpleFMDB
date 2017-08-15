//
//  TwoViewController.m
//  数据库
//
//  Created by 胡高广 on 2017/7/3.
//  Copyright © 2017年 胡高广. All rights reserved.
//

#import "TwoViewController.h"
#import "FMDB.h"
#import "MJExtension.h"
@interface TwoViewController ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation TwoViewController
@synthesize db;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据库2";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //创建路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"operDB.sqlite"];
    //得到数据库
    db = [FMDatabase databaseWithPath:filename];
    
    //创建视图
    [self createUI];
    
    // Do any additional setup after loading the view.
}
//创建视图
-(void)createUI
{
    //打开数据库
    UIButton *openButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    openButton.frame = CGRectMake(100, 100, 200, 30);
    [openButton setTitle:@"打开" forState:(UIControlStateNormal)];
    [openButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    openButton.backgroundColor = [UIColor blackColor];
    [openButton addTarget:self action:@selector(openBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:openButton];
    //创表数据库
    UIButton *tronButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    tronButton.frame = CGRectMake(100, CGRectGetMaxY(openButton.frame) + 20, 200, 30);
    [tronButton setTitle:@"创表" forState:(UIControlStateNormal)];
    [tronButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    tronButton.backgroundColor = [UIColor blackColor];
    [tronButton addTarget:self action:@selector(tronButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:tronButton];
    //插入数据库
    UIButton *addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addButton.frame = CGRectMake(100, CGRectGetMaxY(tronButton.frame) + 20, 200, 30);
    [addButton setTitle:@"插入数据" forState:(UIControlStateNormal)];
    [addButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    addButton.backgroundColor = [UIColor blackColor];
    [addButton addTarget:self action:@selector(addButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addButton];
    //查询数据
    UIButton *lookButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lookButton.frame = CGRectMake(100, CGRectGetMaxY(addButton.frame) + 20, 200, 30);
    [lookButton setTitle:@"查询数据" forState:(UIControlStateNormal)];
    [lookButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    lookButton.backgroundColor = [UIColor blackColor];
    [lookButton addTarget:self action:@selector(lookButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:lookButton];
    //查询数据 (根据id)
    UIButton *lookIDButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lookIDButton.frame = CGRectMake(100, CGRectGetMaxY(lookButton.frame) + 20, 200, 30);
    [lookIDButton setTitle:@"根据id查询数据" forState:(UIControlStateNormal)];
    [lookIDButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    lookIDButton.backgroundColor = [UIColor blackColor];
    [lookIDButton addTarget:self action:@selector(lookIDButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:lookIDButton];
    //修改
    UIButton *changButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    changButton.frame = CGRectMake(100, CGRectGetMaxY(lookIDButton.frame) + 20, 200, 30);
    [changButton setTitle:@"修改数据" forState:(UIControlStateNormal)];
    [changButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    changButton.backgroundColor = [UIColor blackColor];
    [changButton addTarget:self action:@selector(changButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:changButton];
    //根据id删除
    UIButton *cutIDButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cutIDButton.frame = CGRectMake(100, CGRectGetMaxY(changButton.frame) + 20, 200, 30);
    [cutIDButton setTitle:@"根据id删除数据" forState:(UIControlStateNormal)];
    [cutIDButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    cutIDButton.backgroundColor = [UIColor blackColor];
    [cutIDButton addTarget:self action:@selector(cutIDButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:cutIDButton];
    //全部删除
    UIButton *cutALLButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cutALLButton.frame = CGRectMake(100, CGRectGetMaxY(cutIDButton.frame) + 20, 200, 30);
    [cutALLButton setTitle:@"删除全部数据" forState:(UIControlStateNormal)];
    [cutALLButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    cutALLButton.backgroundColor = [UIColor blackColor];
    [cutALLButton addTarget:self action:@selector(cutALLButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:cutALLButton];
    //删除列表
    UIButton *cutListButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cutListButton.frame = CGRectMake(100, CGRectGetMaxY(cutALLButton.frame) + 20, 200, 30);
    [cutListButton setTitle:@"删除表" forState:(UIControlStateNormal)];
    [cutListButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    cutListButton.backgroundColor = [UIColor blackColor];
    [cutListButton addTarget:self action:@selector(cutListButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:cutListButton];


}
#pragma mark -- 打开数据库
-(void)openBtn:(UIButton *)sender
{
    if([db open]){
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}
#pragma mark -- 创表
-(void)tronButton:(UIButton *)sender
{
    if([db open]){
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS shopCar (dbid integer PRIMARY KEY AUTOINCREMENT,specId integer NOT NULL,shopNum integer NOT NULL,shopInfo TEXT NOT NULL);"];
        if(result){
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }
}
#pragma mark -- 插入数据
-(void)addButton:(UIButton *)sender
{
    if([db open]){
        for (int i = 0; i < 5; i++) {
            NSDictionary *dict = @{@"shopId":@(i),@"shopName":@"小红红",@"shopPrice":@(55.9)};
            NSString *shopInfo = [dict mj_JSONString];
            //插入
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO shopCar (specId,shopNum,shopInfo) VALUES (%d,%d,'%@')",i+1,i+2,shopInfo];
            BOOL res = [db executeUpdate:insertSql];
            if(res){
                NSLog(@"数据插入成功");
            }else{
                NSLog(@"数据插入失败");
            }
        }
    }

        [db close];
}
#pragma mark -- 查询数据
-(void)lookButton:(UIButton *)sender
{
    if([db open]){
        NSString *sql = @"SELECT * FROM shopCar";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            int dbId = [rs intForColumn:@"dbid"];
            int specId = [rs intForColumn:@"specId"];
            int shopNum = [rs intForColumn:@"shopNum"];
            NSString *shopInfo = [rs stringForColumn:@"shopInfo"];
            NSLog(@"dbId = %d, specId = %d, shopNum = %d  shopInfo = %@", dbId, specId, shopNum, shopInfo);
        }
        [db close];
    }
}
#pragma mark -- 根据id查询数据
-(void)lookIDButton:(UIButton *)sender
{
    if([db open]){
        NSString *sql = @"SELECT * FROM shopCar WHERE dbid = '3'";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int dbId = [rs intForColumn:@"dbid"];
            int specId = [rs intForColumn:@"specId"];
            int shopNum = [rs intForColumn:@"shopNum"];
            NSString *shopInfo = [rs stringForColumn:@"shopInfo"];
            NSLog(@"dbId = %d, specId = %d, shopNum = %d,shopInfo = %@",dbId,specId,shopNum,shopInfo);
        }
        [db close];
    }
}
#pragma mark -- 修改数据
-(void)changButton:(UIButton *)sender
{
    if([db open]){
        NSString *updateSql = [NSString stringWithFormat:@"update shopCar set shopNum = '88' where dbid = '3'"];
        BOOL res = [db executeUpdate:updateSql];
        if(res){
            NSLog(@"修改数据成功");
        }else{
            NSLog(@"修改数据失败");
        }
        [db close];
    }
}
#pragma mark -- 根据id删除数据
-(void)cutIDButton:(UIButton *)sender
{
    if([db open]){
        NSString *updateSql = [NSString stringWithFormat:@"DELETE FROM shopCar WHERE dbid = '3'"];
        BOOL res = [db executeUpdate:updateSql];
        if(res){
            NSLog(@"删除指定数据成功");
        }else{
            NSLog(@"删除指定数据失败");
        }
        [db close];
    }
}
#pragma mark -- 全部删除
-(void)cutALLButton:(UIButton *)sender
{
    if([db open]){
        NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM shopCar"];
        [db executeUpdate:@"UPDATE sqlite_sequence set seq = 0 where name = 'shopCar'"];
        BOOL res = [db executeUpdate:deleteSql];
        if(res){
            NSLog(@"清空表数据成功");
        }else{
            NSLog(@"清空表数据失败");
        }
        [db close];
    }
}
#pragma mark -- 删除表
-(void)cutListButton:(UIButton *)sender
{
    if([db open]){
        NSString *deleteSql = @"DROP TABLE shopCar";
        BOOL res = [db executeUpdate:deleteSql];
        if(res){
            NSLog(@"删除shopCar表成功");
        }else{
            NSLog(@"删除shopCar表失败");
        }
        [db close];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
