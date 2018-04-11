//
//  DisplayDataViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/29.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "DisplayDataViewController.h"

@interface DisplayDataViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSString *message;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) Boolean isScrolltoTop;

@end

@implementation DisplayDataViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil message: (NSString *)message {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.message = message;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label1.text = self.message;
    self.scrollView.delegate = self;
}
- (IBAction)dismissButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self.delegate updateDataViewController:self];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat minOffsetToTriggerRefresh = 50.0f;
    if (scrollView.contentOffset.y <= -minOffsetToTriggerRefresh) {
        self.isScrolltoTop = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isScrolltoTop) {
        [self.delegate updateDataViewController:self];
        NSLog(@"update data");
        self.isScrolltoTop = NO;
    }
}

@end
