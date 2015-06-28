//
//  ViewController.m
//  RegionMonitor
//
//  Created by CodeMunkeys on 6/28/15.
//  Copyright (c) 2015 CodeMunkeys. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.userNameLabel.delegate = self;
    self.passwordLabel.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButtonClicked:(UIButton *)sender {
    NSLog(@"TEST");
}


#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (!([self.userNameLabel.text isEqualToString:@"codemunkey"] &&
            [self.passwordLabel.text isEqualToString:@"password"]))
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Login"
                              message: @"Login has failed!"
                              delegate: self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK",nil];
        [alert show];
        return YES;
    }
    else
    {
        return YES;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"TEST");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
