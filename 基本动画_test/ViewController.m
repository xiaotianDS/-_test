//
//  ViewController.m
//  基本动画_test
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 wen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animationView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.animationView.layer.shadowOffset = CGSizeMake(5, 5);
    self.animationView.layer.shadowOpacity = 0.5;
    
    self.imgView.image = [UIImage imageNamed:@"from"];
    
}
- (IBAction)pingyi {
    
    NSLog(@"平移");
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
    //设置动画持续时间
    [animation setDuration:0.7];
    //设置动画的终点的属性
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.animationView.center.x, self.animationView.center.y + 400)]];
    
    //动画的重复次数
//    [animation setRepeatCount:4];
    
    
    //动画速度的变化，默认为kCAMediaTimingFunctionLinear
    /*
     kCAMediaTimingFunctionLinear   匀速（不设置该属性时的默认值）
     kCAMediaTimingFunctionEaseIn   动画开始时会较慢，之后动画会加速。
     kCAMediaTimingFunctionEaseOut  动画在开始时会较快，之后动画速度减慢
     kCAMediaTimingFunctionEaseInEaseOut  动画在开始和结束时速度较慢，中间时间段内速度较快
     kCAMediaTimingFunctionDefault  它和kCAMediaTimingFunctionEaseInEaseOut很类似，但是加速和减速的过程都稍微有些慢（注：该值并不是默认值）
     */
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    //默认值为yes，要想setFillMode有效，必须将setRemovedOnCompletion置为no
    [animation setRemovedOnCompletion:NO];
//    动画在开始和结束时的动作，默认值是 kCAFillModeRemoved
    /*
     kCAFillModeForwards 动画开始之后layer的状态将保持在动画的最后一帧
     kCAFillModeBackwards  将会立即执行动画的第一帧，不论是否设置了 beginTime属性。观察发现，设置该值，刚开始视图不见，还不知道应用在哪里。
     kCAFillModeBoth  该值是 kCAFillModeForwards 和 kCAFillModeBackwards的组合状态，动画结束后回到准备状态,并保持最后状态
     kCAFillModeRemoved  动画将在设置的 beginTime 开始执行（如没有设置beginTime属性，则动画立即执行），动画执行完成后将会layer的改变恢复原状
     */
    [animation setFillMode:kCAFillModeRemoved];
    
    
    //设置自动翻转
    //设置自动翻转以后单次动画时间不变，总动画时间增加一倍，它会让你前半部分的动画以相反的方式动画过来
    //比如说你设置执行一次动画，从a到b时间为1秒，设置自动翻转以后动画的执行方式为，先从a到b执行一秒，然后从b到a再执行一下动画结束
    [animation setAutoreverses:YES];
    
    //指定动画开始的时间。从开始延迟几秒的话，设置为CACurrentMediaTime() + 秒数 的方式
    [animation setBeginTime:CACurrentMediaTime() + 1];
    
    [self.animationView.layer addAnimation:animation forKey:@"PositionAnimation"];
    
}
- (IBAction)xuanzhuan {
    NSLog(@"旋转");
    
    //创建旋转动画，并指定旋转方向（默认沿着z轴旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    //设置时间
    [animation setDuration:4];
    
    //设置终止位置
    [animation setToValue:@(M_PI*2)];
    
    //设置动画速度的变化
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    //自动翻转
    [animation setAutoreverses:YES];
    
    [animation setRemovedOnCompletion:NO];
    
    [animation setFillMode:kCAFillModeRemoved];
    
    [self.animationView.layer addAnimation:animation forKey:@"RotationAnimation"];
    
}
- (IBAction)suofang {
    NSLog(@"缩放");
    
    //缩放动画,若指定x、y等坐标轴，将沿着坐标轴方向进行缩放；不指定的情况下将默认等比缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    [animation setDuration:1];
    
    [animation setFromValue:@1.0];
    [animation setToValue:@2.0];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [animation setAutoreverses:YES];
    
    [animation setRemovedOnCompletion:NO];
    
    [animation setFillMode:kCAFillModeRemoved];
    
    [animation setDelegate:self];
    
    [self.animationView.layer addAnimation:animation forKey:@"ScaleAnimation"];
    
}
- (IBAction)danrudanchu {
    NSLog(@"淡入淡出");
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    [animation setFromValue:@1.0];
    [animation setToValue:@0.1];
    
    [animation setDuration:1];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
//    [animation setRemovedOnCompletion:NO];
//    [animation setFillMode:kCAFillModeForwards];
    
    [animation setAutoreverses:YES];
    
    [animation setDelegate:self];
    
    [self.animationView.layer addAnimation:animation forKey:@"OpacityAnimation"];
    
}

- (IBAction)yuanjiao {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    
    [animation setToValue:@25];
    
    [animation setDuration:1.0];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [animation setAutoreverses:YES];
    
    [self.animationView.layer addAnimation:animation forKey:@"CornerRadiusAnimation"];
    
}


- (IBAction)beijingyanse {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    //注意：使用背景颜色变化的动画时，设置颜色值必须转换成CGColor，原因可能是因为动画都是加在图层layer上的
//    [animation setFromValue:(id)([UIColor brownColor].CGColor)];
    [animation setToValue:(id)([UIColor blueColor].CGColor)];
    
    [animation setDuration:1.0];
    [animation setAutoreverses:YES];
    
    [self.animationView.layer addAnimation:animation forKey:@"ColorAnimation"];
    
}

- (IBAction)beijingtupian {
    
    self.imgView.image = [UIImage imageNamed:@"from"];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    
    [animation setFromValue:(id)([UIImage imageNamed:@"from"].CGImage)];
    [animation setToValue:(id)([UIImage imageNamed:@"to"].CGImage)];
    
    [animation setDuration:1.0];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setAutoreverses:YES];
    
    [self.imgView.layer addAnimation:animation forKey:@"ContentAnimation"];
    
}

/**
 *  动画开始和动画结束时 self.demoView.center 是一直不变的，说明动画并没有改变视图本身的位置
 */
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始------：%@",    NSStringFromCGPoint(self.animationView.center));
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画结束------：%@",    NSStringFromCGPoint(self.animationView.center));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
