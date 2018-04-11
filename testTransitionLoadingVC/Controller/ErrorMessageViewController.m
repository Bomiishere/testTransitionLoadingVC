//
//  ErrorMessageViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/24.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "ErrorMessageViewController.h"

@interface ErrorMessageViewController ()

@property (nonatomic, weak) IBOutlet UIButton *tryConnectButton;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) NSString *message;

@end

@implementation ErrorMessageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil message: (NSString *)message {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.message = message;
    }
    return self;
}

- (void)tryConnectButtonTapped {
    [self.delegate tryConnectAgianInMessageViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = self.message;
    [self.tryConnectButton addTarget:self action:@selector(tryConnectButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

@end
