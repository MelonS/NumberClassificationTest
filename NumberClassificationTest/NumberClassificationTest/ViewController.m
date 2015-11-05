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
    
    double assistant = 0.1f;
    
    double threshold = getRandFloat(-0.5f, -0.1f);
    
    double w1 = getRandFloat(-0.5f, 0.5f);
    double w2 = getRandFloat(-0.5f, 0.5f);
    
    int x1 = 1;
    int x2 = 0;
    int expectation = 1;
    
    double sample[] = {x1, x2};
    
    NSArray *netConfig = @[@2, @1];
    
    
    for (int i = 0; i < 10; ++i)
    {
        NSLog(@"threshold:%f, w1:%f, w2:%f",threshold,w1,w2);
        
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
            // 에러 발생 가중치 보정하기
            w1 += assistant * x1 * error;
            w2 += assistant * x2 * error;
        }else{
            NSLog(@"정답");
        }
        
        NSLog(@"=========================================");
    }
    
    // --TODO 1
    // --앞으로 할것 이상태에서 http://destiny738.tistory.com/m/post/455 참고하여
    // --2-1 network 에서 가중치 학습으로 로직추가하기
    // TODO 2
    // 1이 완료된다면 sample 경우의수를 전부다 컨테이너에 넣고 루프를 수행할때마다 선택해서 수행하게 변경하기
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
