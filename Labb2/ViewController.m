//
//  ViewController.m
//  Labb2
//
//  Created by Samantha Morrison on 12/02/17.
//  Copyright © 2017 Samantha Morrison. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()
@property (nonatomic) Model *game;
@property (weak, nonatomic) IBOutlet UITextView *roundResultText;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *questionText;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn1;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn2;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn3;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn4;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionBtn;
@property (weak, nonatomic) IBOutlet UITextView *correctAnswersText;
@property (weak, nonatomic) IBOutlet UITextView *incorrectAnswersText;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.roundResultText.hidden = YES;
    [self hideResultText];
    [self startNewGame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showQuestion {
    NSMutableArray *randomAnswers = [NSMutableArray arrayWithObjects:self.game.currentQuestion[@"Correct"], self.game.currentQuestion[@"Wrong1"], self.game.currentQuestion[@"Wrong2"], self.game.currentQuestion[@"Wrong3"], self.game.currentQuestion[@"Wrong4"], nil];
    
    
    for (int i = 0; i < randomAnswers.count; i++) {
        int n = (arc4random() % (randomAnswers.count - i) + i);
        [randomAnswers exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    [self.answerBtn1 setTitle:randomAnswers[0] forState:UIControlStateNormal];
    [self.answerBtn2 setTitle:randomAnswers[1] forState:UIControlStateNormal];
    [self.answerBtn3 setTitle:randomAnswers[2] forState:UIControlStateNormal];
    [self.answerBtn4 setTitle:randomAnswers[3] forState:UIControlStateNormal];
    self.questionText.text = self.game.currentQuestion[@"Question"];
    self.nextQuestionBtn.hidden = YES;
}

- (void)hideAnswerButtons {
    self.answerBtn1.hidden = YES;
    self.answerBtn2.hidden = YES;
    self.answerBtn3.hidden = YES;
    self.answerBtn4.hidden = YES;
}
- (void)showAnswerButtons {
    self.answerBtn1.hidden = NO;
    self.answerBtn2.hidden = NO;
    self.answerBtn3.hidden = NO;
    self.answerBtn4.hidden = NO;
}

- (void)disableAnswerButtons {
    self.answerBtn1.enabled = NO;
    self.answerBtn2.enabled = NO;
    self.answerBtn3.enabled = NO;
    self.answerBtn4.enabled = NO;
}

- (void)enableAnswerButtons {
    self.answerBtn1.enabled = YES;
    self.answerBtn2.enabled = YES;
    self.answerBtn3.enabled = YES;
    self.answerBtn4.enabled = YES;
}

- (void)hideResultText {
    self.correctAnswersText.hidden = YES;
    self.incorrectAnswersText.hidden = YES;
}

- (IBAction)pressedAnswerButton:(id)sender {
    UIButton *pressedBtn = (UIButton *)sender;
    self.roundResultText.hidden = NO;
    if ([self.game isAnswerCorrect:pressedBtn.titleLabel.text]) {
        self.roundResultText.textColor = [UIColor greenColor];
        self.roundResultText.text = @"Rätt svar!";
    } else {
        self.roundResultText.textColor = [UIColor redColor];
        self.roundResultText.text = @"Fel svar!";
    }
    [self disableAnswerButtons];
    self.nextQuestionBtn.hidden = NO;
}

- (IBAction)pressedNextQuestionButton:(id)sender {
    self.roundResultText.hidden = YES;
    if ([[self.nextQuestionBtn currentTitle] isEqualToString:@"Nästa fråga"] || [[self.nextQuestionBtn currentTitle] isEqualToString:@"Visa resultat"]) {
        if (self.game.isGameActive) {
            if ([self.game isLastQuestion]) {
                [self.nextQuestionBtn setTitle:@"Visa resultat" forState:UIControlStateNormal];
            }
            [self showQuestion];
            [self enableAnswerButtons];
        } else {
            [self hideAnswerButtons];
            [self setUpAndShowResultText];
            [self.nextQuestionBtn setTitle:@"Spela igen" forState:UIControlStateNormal];
        }
    } else {
        [self hideResultText];
        [self startNewGame];
        [self showQuestion];
        [self enableAnswerButtons];
        [self showAnswerButtons];
    }
}

- (void)startNewGame {
    self.game = [[Model alloc]init];
    [self.nextQuestionBtn setTitle:@"Nästa fråga" forState:UIControlStateNormal];
    [self showQuestion];
}

- (void)setUpAndShowResultText {
    self.correctAnswersText.text = [NSString stringWithFormat:@"Antal rätt:  %d", self.game.correctGuesses];
    self.incorrectAnswersText.text = [NSString stringWithFormat:@"Antal fel:  %d", self.game.incorrectGuesses];
    self.questionText.text = @"Resultat";
    self.correctAnswersText.hidden = NO;
    self.incorrectAnswersText.hidden = NO;
}

@end
