//
//  SZKoclaJScontextModel.h
//  JS_OC_JavaScriptCore
//
//  Created by 李然豪 on 17/4/7.
//  Copyright © 2017年 Haley. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSExportDelegate <JSExport>

-(void)scanClick;

-(void)payClick;
-(void)share;
@end
@protocol SZKoclaJScontextModelDelegate <NSObject>

-(void)scanClick;

-(void)payClick;

-(void)share;
@end
@interface SZKoclaJScontextModel : NSObject<JSExportDelegate>
@property (strong, nonatomic)JSContext *jsContext;

@property (weak, nonatomic)id<SZKoclaJScontextModelDelegate>delegate;
@end
