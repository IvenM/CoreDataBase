//
//  CoreDataBase.h
//  CoreDataBase
//
//  Created by Iven on 16/4/17.
//  Copyright © 2016年 Iven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataBase : NSObject

//1.打开数据库
+(void)openDataBaseWithFileName:(NSString*)fileName;

//2.创建表格
+(void)createTableWithSQL:(NSString *)createSQLMessage;

//3.插入一条语句
+(void)insertDataBaseWihtSQL:(NSString*)insertSQLMessage;

//4.查询
+(void)selectDataBaseWithSQL:(NSString*)selectSQLMessage withBlock:(void(^)(id response))sucBlock;

//5.关闭数据库
+(void)closeDataBase;
@end
