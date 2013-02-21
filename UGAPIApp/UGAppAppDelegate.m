//
//  UGAppAppDelegate.m
//  UGAPIApp
//
//

#import "UGAppAppDelegate.h"
#import "UGHTTPManager.h"
#import "SBJson.h"
#import "UGClient.h"
#import "UGClientResponse.h"

UGClient *g_client = nil;
int g_taps = 0;

//configure the org and app
NSString * orgName = @"nimasy";
NSString * appName = @"sandbox";

NSString * username = @"myuser";
NSString * password = @"mypass";

@implementation UGAppAppDelegate

@synthesize window = _window;
@synthesize usergridClient, user;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // called when there's a touch.
    [self testUGClient];
}

-(void)testUGClient
{
    // creation and init
    if ( !g_client )
    {
        //make new client
        g_client =[[UGClient alloc]initWithOrganizationId: orgName withApplicationID: appName];
    }
    
    username = @"myuser";
    password = @"mypass";
    
    UGClientResponse * response = [g_client logInUser:username password:password];
    //user = [usergridClient getLoggedInUser];
    if (!user.username)
    {
        [self outputResponse:response title:@"LOG IN ERROR"];
        return;
    }
    
}

-(void)ugClientResponse:(UGClientResponse *)response
{
    // note the results
    [self outputResponse:response title:@"Asynch Response"];
}

-(void)outputResponse:(UGClientResponse *)response title:(NSString *)title
{
    NSLog(@"-----%@-----", title);
    if ( !response )
    {
        NSLog(@"Response is nil");
        NSLog(@"------------------");
        return;
    }
    
    
    if ( [response transactionState] == kUGClientResponseSuccess )
    {
        NSLog(@"state: SUCCESS");
        NSLog(@"id: %d", [response transactionID]);
        NSLog(@"raw:\n%@", [response rawResponse]);
    }
    else if ( [response transactionState] == kUGClientResponsePending )
    {
        NSLog(@"state: PENDING");
        NSLog(@"id: %d", [response transactionID]);
    }
    else if ( [response transactionState] == kUGClientResponseFailure )
    {
        NSLog(@"state: FAILURE");
        NSLog(@"id: %d", [response transactionID]);
        NSLog(@"reason: '%@'", [response response]);
        NSLog(@"raw:\n%@", [response rawResponse]);
    }
    else 
    {
        NSLog(@"Object is mangled or invalid.");
    }
    NSLog(@"------------------");
}



@end
