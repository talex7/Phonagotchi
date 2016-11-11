//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic, strong) Pet *pet;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecog;
@property (strong, nonatomic) UILongPressGestureRecognizer *lPressRecog;
@property (nonatomic) UIImageView *apple;
@property (nonatomic) UIImageView *bucket;
@property (nonatomic) UIImageView *nApple;



@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    self.bucket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bucket"]];
    self.bucket.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.bucket];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucket
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucket
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucket
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:75]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucket
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:75]];

    self.apple = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple"]];
    self.apple.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.apple];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.apple
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bucket
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:-2.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.apple
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bucket
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:-10.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.apple
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.apple
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:40]];

    
    self.lPressRecog = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(feedApple:)];
    [self.apple addGestureRecognizer:self.lPressRecog];
    self.apple.userInteractionEnabled = YES;
    
    self.panRecog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(checkVelocity:)];
    [self.petImageView addGestureRecognizer:self.panRecog];
    self.petImageView.userInteractionEnabled = YES;
    
    
}

-(void)checkVelocity:(UIPanGestureRecognizer*)sender {
    double x = [sender velocityInView:self.petImageView].x;
    double y = [sender velocityInView:self.petImageView].y;
    CGFloat velocity = sqrt(pow(x, 2) + pow(y, 2));

    if (sender.state == UIGestureRecognizerStateEnded) {
        self.petImageView.image = [UIImage imageNamed:@"default"];
        return;
    }

    if (velocity > 3000) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }

}

-(void)feedApple:(UILongPressGestureRecognizer*)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.nApple = [[UIImageView alloc] initWithImage:self.apple.image];
            self.nApple.frame = self.apple.frame;
            [self.view addSubview:self.nApple];
            break;
        case UIGestureRecognizerStateChanged:
            self.nApple.center = [sender locationInView:self.view];
            break;
        case UIGestureRecognizerStateEnded:
            if (CGRectContainsPoint(self.petImageView.frame, self.nApple.center)) {
                [self.nApple removeFromSuperview];
                self.nApple = nil;
            } else
              [UIView animateWithDuration:1
                                    delay:0
                                  options:UIViewAnimationOptionCurveEaseIn
                               animations:^{
                                   self.nApple.center = CGPointMake(self.nApple.center.x, self.view.frame.size.height);
                               }
                               completion:^(BOOL finished) {
                                   [self.nApple removeFromSuperview];
                                   self.nApple = nil;
                               }];
            break;
        default:
            break;
    }

        
}



@end
