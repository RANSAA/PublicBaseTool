//
//  ViewController.m
//  SignInApple
//
//  Created by PC on 2021/4/13.
//

#import "ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>



@interface ViewController () <ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self appleLogin];
}

//apple id 登录
/**
 参考地址
 apple官方：https://developer.apple.com/cn/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple/
 简书1：https://www.jianshu.com/p/483b998f2370
 简书2：https://sg.jianshu.io/p/efb02bc8935a
 github: https://github.com/WoNiu361/SignInWithApple
 */
- (void)appleLogin
{
    //先校验之前的授权状态
    if (@available(iOS 13.0, *)) {
        [self authorizationCredentialState];
        
        //注意：按钮的样式会随bounds.size的变化二改变
        ASAuthorizationAppleIDButton *btn = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
        CGRect frame = btn.bounds;
        frame.origin = CGPointMake(120, 240);
//        frame.size.height = 50+10;
//        frame.size.width = 50+10;
        frame.size.height = 44;
        frame.size.width = 44;
        btn.frame = frame;
        btn.cornerRadius = frame.size.height/2.0;
        [btn addTarget:self action:@selector(handleAuthorization) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark action中提出授权请求
/**
 handleAuthorization里主要是跟用户提出用苹果登陆请求，并要求用户提供用户名和email.
 发出请求需要创建ASAuthorizationController, 但是需要提供delegate 和 presentationContextProvider.
 ASAuthorizationControllerDelegate会提供请求后的结果回调，比如用户请求失败，或者用户请求成功。
 presentationContextProvider是为验证的用户界面提供所需的window.
 */
- (void)handleAuthorization
{

    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *requestID = provider.createRequest;
        requestID.requestedOperation = ASAuthorizationOperationLogin;//
        requestID.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
        
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[requestID]];
        controller.delegate = self;
        controller.presentationContextProvider = self;
        [controller performRequests];
    } else {
        // Fallback on earlier versions
    }

}

#pragma mark ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0))
{
    NSLog(@"didCompleteWithError:\n%@",error);
    NSLog(@"错误信息：%@", error);
    NSString *errorMsg;
   switch (error.code) {
       case ASAuthorizationErrorCanceled:
           errorMsg = @"用户取消了授权请求";
           NSLog(@"errorMsg -   %@",errorMsg);
           break;
           
       case ASAuthorizationErrorFailed:
           errorMsg = @"授权请求失败";
           NSLog(@"errorMsg -   %@",errorMsg);
           break;
           
       case ASAuthorizationErrorInvalidResponse:
           errorMsg = @"授权请求响应无效";
           NSLog(@"errorMsg -   %@",errorMsg);
           break;
           
       case ASAuthorizationErrorNotHandled:
           errorMsg = @"未能处理授权请求";
           NSLog(@"errorMsg -   %@",errorMsg);
           break;
           
       case ASAuthorizationErrorUnknown:
           errorMsg = @"授权请求失败未知原因";
           NSLog(@"errorMsg -   %@",errorMsg);
           break;
                       
       default:
           break;
   }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0))
{
    NSLog(@"didCompleteWithAuthorization");

    /**
     苹果提供的用户ID：credential.user
     用户emai: credential.email
     用户名信息：credential.fullName
     验证信息状态：credential.state
     refresh token: let code = credential.authorizationCode, let codeStr = String(data: code, encoding: .utf8)
     access token: let idToken = credential.identityToken, let tokeStr = String(data: idToken, encoding: .utf8)
     */
    
    /**
     如果你选择<共享我的电子邮件>，那么在授权成功后，你会拿到真实的邮箱：
     如果你选择<隐藏邮件地址>，那么在授权成功后，你会拿到一个经过处理后的混乱的邮箱：
     */
    
    if ([authorization.credential isKindOfClass:ASAuthorizationAppleIDCredential.class]) {
        //用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        NSString *user = credential.user;
        NSData *identify = credential.identityToken;
        // 拿到用户的验证信息，这里可以跟自己服务器所存储的信息进行校验，比如用户名是否存在等。
    }else if ([authorization.credential isKindOfClass:ASPasswordCredential.class]){
        //用户使用现有的密码凭证
        ASPasswordCredential *credential = (ASPasswordCredential *)authorization.credential;
        //密码凭证对象用户标识，用户唯一标识
        NSString *user = credential.user;
        NSString *pwd  = credential.password;
    }else{
        NSLog(@"授权信息不符");
    }
    
    
    
    

    
}


#pragma mark ASAuthorizationControllerPresentationContextProviding
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0))
{
//    return UIApplication.sharedApplication.delegate.window;
    return self.view.window;
}


#pragma mark 处理用户授权/用户信息变更.
/**
 请求之前可以先校验处理处理用户授权/用户信息变更.
 */
- (void)authorizationCredentialState API_AVAILABLE(ios(13.0))
{
    // Override point for customization after application launch.
    NSString *user = @"保存的苹果提供的用户ID：credential.user";
    ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
    [provider getCredentialStateForUserID:user completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
        switch (credentialState) {
            case ASAuthorizationAppleIDProviderCredentialRevoked:// 处理被撤销的授权
                
                break;
                
            case ASAuthorizationAppleIDProviderCredentialAuthorized:// 处理合法的授权
                
                break;
            case ASAuthorizationAppleIDProviderCredentialNotFound://处理没有找到的授权
                
                break;
            case ASAuthorizationAppleIDProviderCredentialTransferred://从来都没有请求授权过
                
                break;
                
            default:
                break;
        }
        NSLog(@"credentialState:%ld",credentialState);
    }];
    

}



// 请求现有的凭证
/**
 
 func performExistingAccountSetupFlows() {
     // Prepare requests for both Apple ID and password providers.
     let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                     ASAuthorizationPasswordProvider().createRequest()]
     
     // Create an authorization controller with the given requests.
     let authorizationController = ASAuthorizationController(authorizationRequests: requests)
     authorizationController.delegate = self
     authorizationController.presentationContextProvider = self
     authorizationController.performRequests()
 }
 
 */


@end
