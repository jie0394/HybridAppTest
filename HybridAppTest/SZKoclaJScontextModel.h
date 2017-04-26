//
//  SZKoclaJScontextModel.h
//  JS_OC_JavaScriptCore
//
//  Created by 李然豪 on 17/4/7.
//  Copyright © 2017年 李然豪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSExportDelegate <JSExport>

//-(void)scanClick;
//
//-(void)payClick;
-(void)share;

-(void)callBack;
@end
@protocol SZKoclaJScontextModelDelegate <NSObject>

//-(void)scanClick;
//
//-(void)payClick;

-(void)share;
-(void)callBackTest;//这里的名字可以和JSExportDelegate不一致
@end
@interface SZKoclaJScontextModel : NSObject<JSExportDelegate>
@property (strong, nonatomic)JSContext *jsContext;

@property (weak, nonatomic)id<SZKoclaJScontextModelDelegate>delegate;
@end
