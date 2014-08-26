//
//  SignUpViewController.m
//  OurMaps
//
//  Created by Wei Lu on 8/25/14.
//  Copyright (c) 2014 OurMaps. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splashscreenIPHONE-01.png"]]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.signUpView.logo setFrame:CGRectMake(0, 0, 320, 568)];
    [self.signUpView sendSubviewToBack:self.signUpView.logo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
