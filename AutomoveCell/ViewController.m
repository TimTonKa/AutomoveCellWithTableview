//
//  ViewController.m
//  AutomoveCell
//
//  Created by apple on 08/01/15.
//  Copyright (c) 2015 Ndot. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    NSInteger currentRow;//跑馬燈現在第幾個row
    NSInteger currentSection;//跑馬燈現在第幾個section
    NSArray  *tableData ;
    NSIndexPath *currentSelection;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini",@"Egg Benedict", nil];

    // Do any additional setup after loading the view, typically from a nib.
    
    if (timer) {
        [timer invalidate];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                 target:self
                                               selector:@selector(nextcell)
                                               userInfo:nil
                                                repeats:YES];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
   //currentSelection = indexPath;
    currentRow = indexPath.row;
    currentSection = indexPath.section;
    
    return cell;
}

- (void)nextcell{
    
    BOOL animation = YES;
    if (!currentSection) {
        currentSection = 0;
    }
    if (!currentRow) {
        currentRow = 0;
    }
    
    /*  如果在cellForRowAtIndexPath裡
        使用currentSelection = indexPath，
        在iOS 10 時，
        此method所讀取到的indexPath會變成不是NSIndexPath型態的亂數
     */
    currentSelection = [NSIndexPath indexPathForRow:currentRow+1 inSection:currentSection];
    
    if (currentSelection.row == tableData.count) {//資料輪播完畢
        currentSection = 0;
        currentRow = 0;
        currentSelection = [NSIndexPath indexPathForRow:currentRow inSection:currentSection];
        
        /*從最後一筆到第一筆讓其不顯示動畫才不會造成播放動畫不順
         ，因為最後一筆資料在先前已先將第一筆資料在加進array裡
         */
        animation = NO;
    } else {
        animation = YES;
    }
    
    [tbl scrollToRowAtIndexPath:currentSelection atScrollPosition:UITableViewScrollPositionTop animated:animation];
    
/*    @try {
        if(currentSelection){
            currentSelection = [NSIndexPath indexPathForRow:currentSelection.row+1 inSection:currentSelection.section];
        }else{
            currentSelection = [NSIndexPath indexPathForRow:0 inSection:0];
        }
        
      //  [tbl selectRowAtIndexPath:currentSelection animated:YES scrollPosition: UITableViewScrollPositionTop];
        [tbl scrollToRowAtIndexPath:currentSelection atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    @catch (NSException *exception) {
        

        currentSelection = 0;
        
       

    }   */
   
    
  
    
}



@end
