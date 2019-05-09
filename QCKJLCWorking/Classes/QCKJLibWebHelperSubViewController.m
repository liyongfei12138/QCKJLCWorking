#import "QCKJLibWebHelperSubViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "QCKJLibWebTools.h"
@interface QCKJLibWebHelperSubViewController ()<UIScrollViewDelegate,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong)  WKWebViewJavascriptBridge *briage;
@end
@implementation QCKJLibWebHelperSubViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self configTopBar];
    [self configWebView];
    [self configBriage];
}
#define kDeviceStatusHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kSmallGray [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1.0f]
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

- (void)configTopBar{
    UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceStatusHeight + 44)];
    topV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topV];
    
    UILabel *topL = [[UILabel alloc] init];
    topL.text = self.titleString;
    topL.font = [UIFont systemFontOfSize:18];
    topL.textAlignment = NSTextAlignmentCenter;
    topL.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    topL.frame = CGRectMake(0, kDeviceStatusHeight + 5, 0, 0);
    [topL sizeToFit];
    topL.frame = CGRectMake((kDeviceWidth-topL.frame.size.width)/2, kDeviceStatusHeight + 12, topL.frame.size.width, topL.frame.size.height);
    [topV addSubview:topL];
    UIButton *backB = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"QCKJBundle" ofType:@"bundle"];
    NSString *path = [bundlePath stringByAppendingPathComponent:@"web_back_nor"];
    
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    
    [backB setBackgroundImage:img forState:UIControlStateNormal];
    backB.imageEdgeInsets = UIEdgeInsetsMake(5, -5, 5, 5);
    [backB sizeToFit];
    backB.frame = CGRectMake(20, kDeviceStatusHeight + 8 + backB.frame.size.height * 0.1, backB.frame.size.width * 0.6, backB.frame.size.height * 0.6);
    
    [backB addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [topV addSubview: backB];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(clcikClose) forControlEvents:UIControlEventTouchUpInside];
    [close setTitleColor: RGBColor(102, 102, 102) forState:UIControlStateNormal];
//    close.frame = CGRectMake(CGRectGetMaxX(backB.frame) ,kDeviceStatusHeight + 8, 0, 0 );
    
    
    [topV addSubview: close];
    
    [close sizeToFit];
    close.frame = CGRectMake(CGRectGetMaxX(backB.frame) + 3, 0, close.frame.size.width, close.frame.size.height);
    close.center = CGPointMake(close.frame.origin.x + 5 + close.frame.size.width * 0.5, backB.center.y);
    [close sizeToFit];
}

- (void)configWebView
{

    self.webView = [[WKWebView alloc]init];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    [self.webView setBackgroundColor:kSmallGray];
    [self.webView setOpaque:NO];

    self.webView.frame = CGRectMake(0, kDeviceStatusHeight +44,kDeviceWidth, kDeviceHeight - kDeviceStatusHeight -44);
    self.webView .scrollView.delegate = self;
    self.webView .navigationDelegate = self;
    self.webView .UIDelegate = self;
    NSURL *url = [NSURL URLWithString:self.urlString];
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
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - kDeviceWidth) / 2, scrollView.contentOffset.y);
}
- (void)clickBack:(UIButton *)btn{
    if ([self.webView canGoBack]) {
        [self.webView  goBack];
    }else{
         [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)clcikClose{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    // 白名单
    if ( [QCKJLibWebTools inRuleArr:strRequest ruleArr:self.rulesArr])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strRequest]];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    // appstore
    else {
        if ([strRequest hasPrefix:@"itms-apps://"]|| [strRequest hasPrefix:@"https://itunes.apple.com/"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strRequest]];
            decisionHandler(WKNavigationActionPolicyCancel);
        }else{
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    }
}
@end


