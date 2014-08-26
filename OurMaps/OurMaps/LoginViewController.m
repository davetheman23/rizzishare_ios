//
//  LoginViewController.m
//  OurMaps
//
//  Created by Wei Lu on 8/25/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

@implementation LoginViewController
@synthesize backgroundImageView;

/* Initialize the loginviewcontroller's fields */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton;
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    signUpViewController.delegate = self;
    self.signUpController = signUpViewController;
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.logInView setLogo:self.backgroundImageView];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splashscreenIPHONE-01.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //self.logInView.logo = self.backgroundImageView;
    [self.logInView.logo setFrame:CGRectMake(0, 0, 320, 568)];
    [self.logInView sendSubviewToBack:self.logInView.logo];
    //self.logInView.signUpLabel.hidden = YES;
    //self.logInView.signUpLabel.text = @"wahaha!";
}

#pragma mark - PFLogInViewController Delegate methods
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    NSLog(@"logged in");
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"error==>%@", error);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
