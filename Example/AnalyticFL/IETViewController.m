//
//  IETViewController.m
//  AnalyticFL
//
//  Created by gaoyang on 11/02/2015.
//  Copyright (c) 2015 gaoyang. All rights reserved.
//

#import "IETViewController.h"
#import "FLAnalyticHelper.h"

@interface IETViewController ()

@end

@implementation IETViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setAccountInfo:(id)sender {
    NSDictionary* dict = @{@"userId":@"userId", @"age":@(20), @"gender":@"male"};
    [[FLAnalyticHelper getInstance] setAccoutInfo:dict];
}

- (IBAction)onEvent:(id)sender {
    [[FLAnalyticHelper getInstance] onEvent:@"eventId"];
}

- (IBAction)onEventWithLabel:(id)sender {
    [[FLAnalyticHelper getInstance] onEvent:@"eventId" Label:@"label"];
}

- (IBAction)setLevel:(id)sender {
    [[FLAnalyticHelper getInstance] setLevel:20];
}

- (IBAction)charge:(id)sender {
    [[FLAnalyticHelper getInstance] charge:@"com.ietstudio.mayaslot.coin1" :6 :100 :1];
}

- (IBAction)reward:(id)sender {
    [[FLAnalyticHelper getInstance] reward:100 :1];
}

- (IBAction)purchase:(id)sender {
    [[FLAnalyticHelper getInstance] purchase:@"prop" :1 :10];
}

- (IBAction)use:(id)sender {
    [[FLAnalyticHelper getInstance] use:@"prop" :1 :10];;
}











@end
