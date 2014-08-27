//
//  LoginViewController.m
//  OurMaps
//
//  Created by Wei Lu on 8/25/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "ViewController.h"

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
    signUpViewController.fields = PFSignUpFieldsDefault - PFSignUpFieldsEmail;
    signUpViewController.delegate = self;
    self.delegate = self;
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
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;

}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    NSLog(@"logged in");
    [self performSegueWithIdentifier:@"Login_success" sender:self];
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"error==>%@", error);
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Error", nil) message:NSLocalizedString(error.description, nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
}

#pragma mark - PFSignUpViewController Delegate methods
//- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
//{
//    BOOL informationComplete = YES;
//    for (id key in info) {
//        NSString *field = [info objectForKey:key];
//        if (!field || field.length==0) {
//            informationComplete = NO;
//            break;
//        }
//    }
//    
//    if (!informationComplete) {
//        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
//    }
//    
//    return informationComplete;
//}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    NSLog(@"new user signed up");
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self performSegueWithIdentifier:@"Login_success" sender:self];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"failed to sign up");
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign Up Error", nil) message:NSLocalizedString(error.description, nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Login_success"]) {
        ViewController *destVC = segue.destinationViewController;
        destVC.usernameLabel.text = [[PFUser currentUser] username];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
