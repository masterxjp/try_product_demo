//
//  AppDelegate.m
//  try_product_demo
//
//  Created by Xu on 2016/10/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UserManager.h"
#import "XJPNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RootViewController* root = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:root];
    nav.navigationBar.translucent = NO;
    nav.tabBarItem.title = @"首页";
    
    UITabBarController* tab = [[UITabBarController alloc] init];
    tab.viewControllers = [NSArray arrayWithObjects:nav, nil];
    
    self.window.rootViewController = tab;
    
//    NSLog(@"%@", [UserManager shareInstance].userid);
    
    
    //iOS10通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound |  UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
        //在block中会传入布尔值granted，表示用户是否同意
        if(granted) {
            
        }
    }];
    
    
    //通知内容类
    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    //为通知内容添加附件
    NSString* imageFilePath = [[NSBundle mainBundle] pathForResource:@"3513" ofType:@"jpg"];
    if(imageFilePath) {
        UNNotificationAttachment* attach = [UNNotificationAttachment attachmentWithIdentifier:@"imageattach"
                                                                                          URL:[NSURL fileURLWithPath:imageFilePath]
                                                                                      options:nil
                                                                                        error:nil];
        if(attach) {
            content.attachments = @[attach];
        }
    }
    //设置通知请求发送时 app图标上显示的数字
    content.badge = @2;
    //设置通知的内容
    content.body = @"这是iOS10的新通知内容：普通的iOS通知";
    //默认的通知提示音
    content.sound = [UNNotificationSound defaultSound];
    //设置通知的副标题
    content.subtitle = @"这里是副标题";
    //设置通知的标题
    content.title = @"这里是通知的标题";
    //设置从通知激活app时的launchImage图片
    content.launchImageName = @"123.png";
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:1];
    UNNotificationAction* actionA = [UNNotificationAction actionWithIdentifier:@"identifierunlock"
                                                                         title:@"需要解锁"
                                                                       options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction* actionB = [UNNotificationAction actionWithIdentifier:@"identifierred"
                                                                         title:@"进入app"
                                                                       options:UNNotificationActionOptionForeground];
    [array addObjectsFromArray:@[actionA, actionB]];
    UNNotificationCategory* category = [UNNotificationCategory categoryWithIdentifier:@"identifiercategory"
                                                                              actions:array
                                                                    intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:category]];
    content.categoryIdentifier = @"identifiercategory";
    
    //设置5S之后执行
    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
    //添加通知请求
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"进入", nil);
    }];
    
    [XJPNetworking ReachabilityStatus:^(NSUInteger status) {
        NSLog([NSString stringWithFormat:@"%lu", (unsigned long)status], nil);
    }];
    [XJPNetworking GET:@"getTinfoList" parameters:@{@"year": @"2016", @"rownum": @"100"} success:^(id success) {
        
    } failure:^(NSError *failure) {
        NSLog([failure.userInfo objectForKey:@"NSLocalizedDescription"], nil);
    } progress:^(float progress) {
        NSLog(@"%f", progress);
    }];
    
    return YES;
}

// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", nil);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
