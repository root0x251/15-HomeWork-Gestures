//
//  ViewController.m
//  15-HomeWork-Gestures
//
//  Created by Slava on 23.04.17.
//  Copyright © 2017 Slava. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *createRect;
@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation ;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createRect = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                                  CGRectGetMidY(self.view.bounds) - 50,
                                                                  100, 100)];
    self.createRect.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.createRect.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.createRect];
    
    
    // tap
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                       action:@selector(handelTap:)];
    [self.view addGestureRecognizer:tapGesture];
    // swipe left
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(handelSwipeLeft:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    // swipe Right
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handelSwipeRight:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    // pinch
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(handelPinch:)];
    [self.view addGestureRecognizer:pinchGesture];
    // rotation
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleGestureRotation:)];
    [self.view addGestureRecognizer:rotationGesture];
    
}
    // метод tap
- (void)handelTap:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    self.createRect.backgroundColor = [self randomColor];                           // if tap - change to random color
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.createRect.center = [tapGesture locationInView:self.view];
                     } completion:^(BOOL finished) {
                         NSLog(@"done");
                     }];
}

    // method swipeLeft
- (void)handelSwipeLeft:(UISwipeGestureRecognizer *)swipeLeftGesture {
    CGAffineTransform curentTransform = self.createRect.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(curentTransform, -3.14);
    //    CGAffineTransform newTransform = CGAffineTransformRotate(curentTransform, -M_PI);
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.createRect.transform = newTransform;
                     } completion:^(BOOL finished) {
                         NSLog(@"end");
                     }];
}
    //method swipeRight
- (void)handelSwipeRight:(UISwipeGestureRecognizer *)swipeRightGesture {
    CGAffineTransform curentTransform = self.createRect.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(curentTransform, 3.14);
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.createRect.transform = newTransform;
                     } completion:^(BOOL finished) {
                         NSLog(@"end");
                     }];
}
    // method pinch
- (void)handelPinch:(UIPinchGestureRecognizer *)pinchGesture {
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    CGFloat delta = 1.f + pinchGesture.scale - self.testViewScale;
    NSLog(@"handle Pinch: %.3f", pinchGesture.scale);
    CGAffineTransform curientScale = self.createRect.transform;
    CGAffineTransform newScale = CGAffineTransformScale(curientScale, delta, delta);
    self.createRect.transform = newScale;
    self.testViewScale = pinchGesture.scale;
}
    // rotation
- (void)handleGestureRotation:(UIRotationGestureRecognizer *)rotationGesture {
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0;
    }
    
    NSLog(@"handle rotation: %.3f", rotationGesture.rotation);
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    CGAffineTransform curientTransform = self.createRect.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(curientTransform, newRotation);
    self.createRect.transform = newTransform;
    self.testViewRotation = rotationGesture.rotation;
    
}
- (UIColor *)randomColor {                                                            // random color
    CGFloat r = (float)(arc4random() % 256) / 255;
    CGFloat g = (float)(arc4random() % 256) / 255;
    CGFloat b = (float)(arc4random() % 256) / 255;
    return [UIColor colorWithRed:r
                           green:g
                            blue:b
                           alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end



//Ученик
//
//Добавьте квадратную картинку на вьюху вашего контроллера
//Если хотите, можете сделать ее анимированной
//Студент
//
//По тачу анимационно передвигайте картинку со ее позиции в позицию тача
//Если я вдруг делаю тач во время анимации, то картинка должна двигаться в новую точку без рывка (как будто она едет себе и все)
//Мастер
//
//Если я делаю свайп вправо, то давайте картинке анимацию поворота по часовой стрелке на 360 градусов
//То же самое для свайпа влево, только анимация должна быть против часовой (не забудьте остановить предыдущее кручение)
//По двойному тапу двух пальцев останавливайте анимацию
//Супермен
//
//Добавьте возможность зумить и отдалять картинку используя пинч
//Добавьте возможность поворачивать картинку используя ротейшн
