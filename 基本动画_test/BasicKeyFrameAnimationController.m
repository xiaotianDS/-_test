//
//  BasicKeyFrameAnimationController.m
//  基本动画_test
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 wen. All rights reserved.
//

#import "BasicKeyFrameAnimationController.h"

@interface BasicKeyFrameAnimationController ()

@property (weak, nonatomic) IBOutlet UIView *animatinView;

@end

@implementation BasicKeyFrameAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)dismissController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)椭圆 {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建一个可变路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, self.animatinView.center.y, self.view.frame.size.width, self.view.frame.size.height-self.animatinView.center.y));
    //给动画添加路径
    [animation setPath:path];
    
    /*
     rotationMode : 旋转样式
     kCAAnimationRotateAuto 根据路径自动旋转
     kCAAnimationRotateAutoReverse 根据路径自动翻转
     */
//    animation.rotationMode = kCAAnimationRotateAuto;
    
    [animation setDuration:1.0];
    [animation setRemovedOnCompletion:NO];
    
    [animation setFillMode:kCAFillModeBoth];
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}

- (IBAction)贝塞尔矩形 {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建贝塞尔矩形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.animatinView.center.y, self.view.frame.size.width, self.view.frame.size.width)];
    //animation需要的类型是CGPathRef，UIBezierPath是ui的,需要转化成CGPathRef
    [animation setPath:path.CGPath];
    
    [animation setDuration:1.0];
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeBoth];
    
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}

- (IBAction)贝塞尔抛物线:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建贝塞尔抛物线路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置抛物线的起点
    [path moveToPoint:self.animatinView.center];
    
    //第一个参数是抛物线的终点；第二个参数是抛物线的控制点（抛物线经过地点和终点切线的交点）
    [path addQuadCurveToPoint:CGPointMake(0,568) controlPoint:CGPointMake(self.animatinView.center.x, 568)];
    
    [animation setPath:path.CGPath];
    
    [animation setDuration:1.0];
    
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeBoth];
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}
- (IBAction)贝塞尔圆:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, self.animatinView.center.y, self.view.frame.size.width, self.view.frame.size.width)];//这种方式的路径，起点为圆的0度。
    
    //画弧线的方法
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.animatinView.center.x, (self.view.frame.size.height-self.animatinView.center.y)*0.5+self.animatinView.center.y) radius:(self.view.frame.size.height-self.animatinView.center.y)*0.5 startAngle:M_PI*0.5 endAngle:M_PI*2.5 clockwise:YES];
    [animation setPath:path.CGPath];
    
    [animation setDuration:3.0];
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeBoth];
    
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}
- (IBAction)弹力仿真:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建路径
    //1、设置路径目标点
    CGPoint endPoint = CGPointMake(self.animatinView.center.x, self.view.frame.size.height-200);
    
    //2、计算起点到目标点的距离
    CGFloat yLength = endPoint.y - self.animatinView.center.y;
    
    //3、实例化可变路径
    CGMutablePathRef path = CGPathCreateMutable();
    //4、将路径起始点移动至动画视图中心
    CGPathMoveToPoint(path, NULL, self.animatinView.center.x, self.animatinView.center.y);
    //5、将目标点的坐标添加到路径中
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    //是否停止动画
    BOOL isStopBounce = NO;
    //设置弹力因子
    CGFloat offsetDivider = 2.0f;
    //6、设置往复路径，实现类似弹簧来回弹动的效果
    while(isStopBounce == NO) {
    
        //根据弹力因子设置返回的路径
        CGPathAddLineToPoint(path, NULL, endPoint.x, yLength/offsetDivider+endPoint.y);
        //返回后再回到目标点
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
        
        //增大弹力因子，每次进入循环后，返回路径的终点将逐渐减小
        offsetDivider += 2.0;
        
        //当视图的当前位置距离目标点足够小我们就退出循环
        if(ABS(yLength / offsetDivider) < 10.0f) {
            isStopBounce = YES;
        }
    }
    
    [animation setPath:path];
    [animation setDuration:2.0];
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeBoth];
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}
- (IBAction)贝塞尔s曲线:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGFloat Y = self.animatinView.center.y;
    CGFloat height = (self.view.frame.size.height - Y)*0.25;
    
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置曲线的起点
    [path moveToPoint:self.animatinView.center];
    //设置终点和控制点
    [path addCurveToPoint:CGPointMake(self.animatinView.center.x, self.view.frame.size.height) controlPoint1:CGPointMake(0, Y+height) controlPoint2:CGPointMake(self.view.frame.size.height, Y+3*height)];
    
    [animation setPath:path.CGPath];
    [animation setDuration:3.0];
    [animation setRemovedOnCompletion:NO];
    
    [animation setFillMode:kCAFillModeBoth];
    
    [self.animatinView.layer addAnimation:animation forKey:nil];
}
- (IBAction)自晃动:(id)sender {
    
    //"transform.rotation"旋转动画，默认是沿着z轴旋转。“transform.rotation.x”沿x轴旋转
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    
    CGFloat angle = M_PI * 0.5;
    
    NSArray *values = @[@(0),@(angle),@(-angle),@(angle),@(0)];
    
    [animation setValues:values];
    
    [animation setDuration:8.0];
    
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeBoth];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}
- (IBAction)指定点平移:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *value0 = [NSValue valueWithCGPoint:self.animatinView.center];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width, self.animatinView.center.y + 200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(0, self.animatinView.center.y + 200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(self.animatinView.center.x, self.view.frame.size.height)];
    
    NSArray *paths = @[value0,value1,value2,value3];
    
    [animation setValues:paths];
    
    [animation setDuration:2.0];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeBoth];
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}
- (IBAction)颜色渐变:(id)sender {
    
    NSLog(@"颜色渐变");
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    
    NSArray *colors = @[self.animatinView.backgroundColor,[UIColor brownColor],[UIColor redColor],[UIColor blueColor],[UIColor cyanColor]];
    
    [animation setValues:colors];
    [animation setDuration:4.0];
    
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeBoth];
    
    [animation setRotationMode:kCAAnimationRotateAutoReverse];
    
    [self.animatinView.layer addAnimation:animation forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
