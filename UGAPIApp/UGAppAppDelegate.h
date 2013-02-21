//
//  UGAppAppDelegate.h
//  UGAPIApp
//
//

#import <UIKit/UIKit.h>
#import "UGClient.h"

@class UGHTTPManager;

@interface UGAppAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UGClient *usergridClient;
@property (nonatomic, strong) UGUser *user;

@end
