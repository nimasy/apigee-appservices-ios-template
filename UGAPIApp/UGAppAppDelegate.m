//
//  UGAppAppDelegate.m
//  UGAPIApp
//
//

#import "UGAppAppDelegate.h"
#import "UGAppViewController.h"
#import "UGHTTPManager.h"
#import "SBJson.h"
#import "UGClient.h"
#import "UGClientResponse.h"

UGClient *UsergridClient = nil;
int g_taps = 0;

@implementation UGAppAppDelegate

NSArray * EntityArray;

@synthesize window = _window;
@synthesize usergridClient, user, appView;

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
    // Follow these steps:
    
    // 1. Initialize the Usergrid SDK
    
    //  Enter your orgName (username you used to register at apigee.com) below.
    //  Keep the appName as “sandbox”: it’s a context we automatically created for you. It’s completely open by default, but don’t worry, other apps you create are not!

    // Creation and init
    if ( !UsergridClient )
    {
        // Configure the org and app names
        NSString * orgName = @"orgName";
        NSString * appName = @"sandbox";

        //Make new client
        UsergridClient =[[UGClient alloc]initWithOrganizationId: orgName withApplicationID: appName];
    }
    
    // 2. Let’s save an object!
    //
    //  Great, we know your account is now! (? ASK TIM) Let’s try to create a book the system and output it on the page.

    //    - Keep the type as “Book”
    //    - Edit the title below with the name of your favorite
   
    NSString *book = @"Book";
    NSString *title = @"War and Peace.";
    
    // Define the new entity and plug in the object 
    NSDictionary *newEntity = [[NSDictionary alloc] initWithObjectsAndKeys:
                          book, @"type",
                          title, @"title",
                          nil];
    
    UGClientResponse * response = [UsergridClient createEntity:newEntity];
    
    // 3. Congrats, you’re done!
    
    // - You can try adding more properties after line 33 and reloading the page!
    // - You can then see the admin view of this data by logging in at https://apigee.com/usergrid
    // - Or you can go explore more advanced examples in our docs: http://apigee.com/docs/usergrid

    // Check the Output window to view response 
    [self outputResponse:response title:@"response"];

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
