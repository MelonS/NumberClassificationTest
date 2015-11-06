//
//  ViewController.m
//  NumberClassificationTest
//
//  Created by Inc.MelonS on 2015. 11. 4..
//  Copyright © 2015년 MelonS. All rights reserved.
//

#import "ViewController.h"

#import "Common.h"
#import "MLPNeuralNet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    double assistant = 0.05f;
    
    double threshold = getRandFloat(-0.5f, -0.1f);
    
    double w1 = getRandFloat(-0.5f, 0.5f);
    double w2 = getRandFloat(-0.5f, 0.5f);
    
    int samples[4][3] = {{0,0,0},{1,0,0},{0,1,0},{1,1,1}};
    
    NSArray *netConfig = @[@2, @1];
    
    int correctCount = 0;
    int incorrectCount = 0;
    
    for (int i = 0; i < 100; ++i)
    {
        NSLog(@"[%d]=========================================",i);
        
        int selectCase = getRandInt(0, 3);
        NSLog(@"selectCase:%d",selectCase);
        int x1 = samples[selectCase][0];
        int x2 = samples[selectCase][1];
        int expectation = samples[selectCase][2];
        
        NSLog(@"sample x1:%d, x2:%d, expectation:%d",x1,x2,expectation);
        NSLog(@"threshold:%f, w1:%f, w2:%f",threshold,w1,w2);
        
        double sample[] = {x1, x2};
        double wts[] = {threshold, w1, w2};
        
        NSData *weights = [NSData dataWithBytes:wts length:sizeof(wts)];
        
        MLPNeuralNet *model = [[MLPNeuralNet alloc] initWithLayerConfig:netConfig
                                                                weights:weights
                                                             outputMode:MLPClassification];
        
        model.outputActivationFunction = MLPTangent;
        
        NSData * vector = [NSData dataWithBytes:sample length:sizeof(sample)];
        NSMutableData * prediction = [NSMutableData dataWithLength:sizeof(double)];
        
        [model predictByFeatureVector:vector intoPredictionVector:prediction];
        NSLog(@"D-%@",[model description]);
        
        double * assessment = (double *)prediction.bytes;
        double assessmentValue = assessment[0];
        NSLog(@"Model assessment is %f", assessmentValue);
        
        int result = (assessmentValue > 0.0) ? 1 : 0;
        NSLog(@"Result : %d",result);
        
        int error = expectation - result;
        if (error != 0) {
            NSLog(@"오답");
            ++incorrectCount;
            // 에러 발생 가중치 보정하기
            w1 += assistant * x1 * error;
            w2 += assistant * x2 * error;
        }else{
            NSLog(@"정답");
            ++correctCount;
        }
        
        NSLog(@"오답횟수:%d, 정답횟수:%d",incorrectCount,correctCount);
    }
    
    // TODO 3
    // 데이터셋 개수 늘러서 테스트하기
    // TODO 4
    // 데이터셋 클래스 구조 만들기.
    // TODO 5
    // MNIST텍스쳐 데이터 가져오기
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
