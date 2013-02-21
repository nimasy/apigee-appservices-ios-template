//
//  UGAppViewController.m
//  UGAPIApp
//
//

#import "UGAppViewController.h"

@interface UGAppViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Label;

@end

@implementation UGAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)SetLabeltext:(NSString*)labletext
{
    labletext = self.Label.text;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
