//
//  CoreDataBase.m
//  CoreDataBase
//
//  Created by Iven on 16/4/17.
//  Copyright © 2016年 Iven. All rights reserved.
//

#import "CoreDataBase.h"
#import <sqlite3.h>
#import "ClassModel.h"

@interface CoreDataBase ()

@end

@implementation CoreDataBase

sqlite3 *_sql;

//打开数据库，需要传入数据库文件名，若不存在，则自动创建
+(void)openDataBaseWithFileName:(NSString*)fileName{


    NSString *file = [NSString stringWithFormat:@"/Documents/%@",fileName];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:file];
    
    int openOK = sqlite3_open([filePath UTF8String], &_sql);
   
    if (openOK == SQLITE_OK) {
        
        NSLog(@"打开数据库成功");
    }

}


//创建表格，具体的sql语句需要外部传入
+(void)createTableWithSQL:(NSString *)createSQLMessage{

    
    char *error = nil;
    
    int createOK = sqlite3_exec(_sql, [createSQLMessage UTF8String], NULL, NULL, &error);
    
    if (createOK == SQLITE_OK) {
        NSLog(@"创建表格成功");
    }

}

+(void)insertDataBaseWihtSQL:(NSString*)insertSQLMessage{

    char *error = nil;
    
    int insertOK = sqlite3_exec(_sql, [insertSQLMessage UTF8String], NULL, NULL, &error);
    
    if (insertOK == SQLITE_OK) {

        NSLog(@"添加数据成功");
        
    }
}

+(void)selectDataBaseWithSQL:(NSString*)selectSQLMessage withBlock:(void(^)(id response))sucBlock{

    // SQL语句的句柄
    sqlite3_stmt *stmt = nil;

    int prepare = sqlite3_prepare_v2(_sql, [selectSQLMessage UTF8String], -1, &stmt, NULL);

  
    if (prepare == SQLITE_OK) {
        NSLog(@"语句合法");
        
        
        sqlite3_bind_int(stmt, 1, 1);
        
        // 执行句柄  开始查询语句
        //        int step = sqlite3_step(stmt);
        NSMutableArray *models = [[NSMutableArray alloc]init];
        
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 说明还有一条数据待查询
            int c_id = sqlite3_column_int(stmt, 0);
            const unsigned char *className = sqlite3_column_text(stmt, 1);
            const unsigned char *teacher = sqlite3_column_text(stmt, 2);
            
            ClassModel *model = [[ClassModel alloc] init];
            model.c_id = c_id;
            model.className = [NSString stringWithUTF8String:className];
            model.teacher = [NSString stringWithUTF8String:teacher];
            
            [models addObject:model];
            
            
        }

        //回调
        sucBlock(models);
   
        
    }

}

+(void)closeDataBase{

    //关闭数据库
    sqlite3_close_v2(_sql);

}

@end
