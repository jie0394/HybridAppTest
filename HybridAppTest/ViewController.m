//
//  ViewController.m
//  HybridAppTest
//
//  Created by 李然豪 on 2017/4/24.
//  Copyright © 2017年 李然豪. All rights reserved.
//

#import "ViewController.h"
#import "SZKoclaJScontextModel.h"
@interface ViewController ()<UIWebViewDelegate,SZKoclaJScontextModelDelegate>
@property (strong, nonatomic)UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_webView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    self.webView.delegate = self;
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    self.webView.backgroundColor = [UIColor clearColor];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    UIBarButtonItem *rightItem  = [[UIBarButtonItem alloc] initWithTitle:@"调用js" style:UIBarButtonItemStylePlain target:self action:@selector(btnJS:)];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
/*****************说明**************
 用model的原因是防止内存泄漏
 
 很多demo是这样写的
 self.jsContext[@"web"] = self;
 但是这样写会造成循环引用，导致内存泄漏
 ****************/
    SZKoclaJScontextModel *model = [SZKoclaJScontextModel new];
    self.jsContext[@"web"] = model;//js方法有别名的，将别名写到这，使用代理方法进行回调，
    model.jsContext = self.jsContext;
    
    [model setDelegate:self];
    
    [self callCamera:self.jsContext];//js方法没有别名，使用block回调；
    
    self.jsContext.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };

}


#pragma mark js调用iOS方法
-(void)share{
    NSArray *args = [JSContext currentArguments];
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"shareCallback()"]];//方法回调成功弹出js的alert;
    NSLog(@"%@",args );
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark iOS调用js方法
-(void)btnJS:(id)sender{
    
    //方式一
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"callCamera()"]];//弹出js的alert;
    
    NSString *result = [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"callBack(%@,%@)",@"123",@"456"]];
    
    //方式二
    JSValue *result1 = [self.jsContext evaluateScript:[NSString stringWithFormat:@"callBack(%@,%@)",@"123",@"789"]];//使用jsContext调用js方法回调成功弹出js的alert;
    
    //方式三
    JSValue *jsFunction = self.jsContext[@"callBack"];
    
   JSValue *result2 = [jsFunction callWithArguments:@[@"345",@"123"]];//如果有参数，数组里面跟对应参数例如：@[@"123",@"ewqe"]
    JSValue *result3 = [jsFunction callWithArguments:@[[NSNumber numberWithInt:123],[NSNumber numberWithInt:567]]];
    NSLog(@"%@",result);
    NSLog(@"%@",[result1 description]);
    NSLog(@"%@",[result2 description]);
    NSLog(@"%@",[result3 description]);
}

-(void)callCamera:(JSContext *)context{
    context[@"callCamera"]=^() {
//         NSArray *args = [JSContext currentArguments];//如果有参数，使用这种方法获取参数；
        NSLog(@"callCamera");
    };
}

-(void)callBackTest{
    NSArray *args = [JSContext currentArguments];
    
    //方式一
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"shareCallback()"]];//使用webView回调成功弹出js的alert;
    NSLog(@"%@",args );
    //方式二
    [self.jsContext evaluateScript:@"shareCallback()"];//使用jsContext调用js方法回调成功弹出js的alert;
    
    //方式三
    JSValue *jsFunction = self.jsContext[@"shareCallback()"];
    
    [jsFunction callWithArguments:@[]];//如果有参数，数组里面跟对应参数例如：@[@"123",@"ewqe"]
}
@end
