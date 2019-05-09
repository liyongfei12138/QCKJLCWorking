#import "QCKJLibMyViewController.h"
#import "UIImage+QCKJImage.h"
#import "QCKJLibWebHelperSubViewController.h"
#import "QCKJLibWebTools.h"
#import "WKWebViewJavascriptBridge.h"
@interface QCKJLibMyViewController ()<UIScrollViewDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSString *titleName;
@property (nonatomic,assign) CGRect webViewFrame;
@property (nonatomic,strong) NSString* webUrl;
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) NSArray* rulesArr;
@property (nonatomic,strong)  WKWebViewJavascriptBridge *briage;
@end

#define kSmallGray [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1.0f]

@implementation QCKJLibMyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:kSmallGray] ];

}

// 初始化
-(instancetype)initWithUrl:(NSString*)url frame:(CGRect)frame payRules:(NSArray *)arr{
    if(self = [super init]){
        self.webUrl = url;
        self.webViewFrame = frame;
        self.rulesArr = [NSArray arrayWithArray:arr];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化webview
    [self configWebView];
    // 初始化h5交互的协议（Briage）
    [self configBriage];
}
- (void)configWebView
{

    self.webView  = [[WKWebView alloc]init];
    self.webView .scrollView.bounces = NO;
    self.webView .scrollView.showsVerticalScrollIndicator = NO;
    self.webView .scrollView.showsHorizontalScrollIndicator = NO;
    [self.webView  setBackgroundColor:[UIColor whiteColor]];
    [self.webView  setBackgroundColor:kSmallGray];
    [self.webView  setOpaque:NO];
    
    
    self.webView.frame = self.webViewFrame;
    self.webView .scrollView.delegate = self;
    self.webView .navigationDelegate = self;
    self.webView .UIDelegate = self;
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURLRequest * urlReuqest = [[NSURLRequest alloc]initWithURL:url cachePolicy:1 timeoutInterval:30.0f];
    [self.webView loadRequest:urlReuqest];
    
    [self.view addSubview:self.webView];
}

- (void)configBriage
{
    
    self.briage = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.briage setWebViewDelegate:self];
    
    __weak __typeof__(self) weakSelf = self;

    

    
    [self.briage registerHandler:@"gotosafari" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *url = [data objectForKey:@"url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }];
    
    [self.briage registerHandler:@"gettitle" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *title = [data objectForKey:@"title"];
        self.navigationItem.title = title;
    }];
    
    
    [self.briage registerHandler:@"gotosubview" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSString *string = [data objectForKey:@"url"];
        //如果是跳转到appstore或者企业签
        if ([string hasPrefix:@"itms-appss://"] || [string hasPrefix:@"https://itunes.apple.com/"] )
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
            
        }
        else{
           
            NSString *title = [data objectForKey:@"title"];
            QCKJLibWebHelperSubViewController *vc = [[QCKJLibWebHelperSubViewController alloc] init];
            vc.urlString = string;
            vc.titleString = title;
            vc.rulesArr = self.rulesArr;
            [self presentViewController:vc animated:YES completion:nil];
        }

    }];
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    if (!navigationAction.targetFrame.isMainFrame) {
        // 跳转到聊天 blank
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
         decisionHandler(WKNavigationActionPolicyAllow);
    }
    else{
        // 白名单
        if ( [QCKJLibWebTools inRuleArr:strRequest ruleArr:self.rulesArr])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strRequest]];
            decisionHandler(WKNavigationActionPolicyCancel);
        }
        // appstore
        else {
            if ([strRequest hasPrefix:@"itms-apps://"] || [strRequest hasPrefix:@"https://itunes.apple.com/"])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strRequest]];
                decisionHandler(WKNavigationActionPolicyCancel);
            }else{
                decisionHandler(WKNavigationActionPolicyAllow);
            }
        }
    }

    
}


@end

