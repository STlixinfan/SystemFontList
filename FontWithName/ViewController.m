//
//  ViewController.m
//  FontWithName
//
//  Created by yusaiyan on 15/7/27.
//  Copyright (c) 2015年 lixinfan. All rights reserved.
//

#import "ViewController.h"
#define bounds_width [[UIScreen mainScreen] bounds].size.width
#define bounds_height [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *_data;
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _data = [[NSMutableArray alloc]init];
    
    NSArray *familyNames = [UIFont familyNames];
    
    NSString *fontName2;
    
    for( NSString *familyName in familyNames ){
//        NSLog(@"Family: %@",familyName);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            NSLog(@"Font: %@",fontName);
            [_data addObject:fontName];
            fontName2 = [NSString stringWithFormat:@"%@\n#define %@\t\t@\"%@\"", fontName2, fontName, fontName];
        }
    }
    NSLog(@"fontName2 == %@",fontName2);
    //取消scrollview内容自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, bounds_width, bounds_height-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //    用TableSampleIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }  else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }

    NSUInteger row = [indexPath row];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, bounds_width/2-10, 20)];
    titleLabel.text = @"字体大全";
    titleLabel.font = [UIFont fontWithName:[_data objectAtIndex:row] size:20.0f];
    [cell addSubview:titleLabel];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(bounds_width/2, 10, bounds_width/2, 20)];
    numberLabel.text = @"1234567890";
    numberLabel.font = [UIFont fontWithName:[_data objectAtIndex:row] size:18.0f];
    [cell addSubview:numberLabel];
    
    UILabel *fontName = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, bounds_width-10, 20)];
    fontName.text = [_data objectAtIndex:row];
    fontName.font = [UIFont fontWithName:[_data objectAtIndex:row] size:10.0f];
    [cell addSubview:fontName];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
