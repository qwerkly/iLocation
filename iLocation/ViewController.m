//
//  ViewController.m
//  iLocation
//
//  Created by Ivan Babich on 17.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) firstLunch {
    NSString * ver = [[UIDevice currentDevice]systemVersion]; // Версия IOS
    if ([ver intValue] >= 8) {        // Если минимальная версия 8
        [self.locationManager requestAlwaysAuthorization]; // Всегда спрашиваем авторизацию
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"FirstLunch"];
        // Устанавливаем ключ
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayM = [NSMutableArray new];
    
    self.mapView.showsUserLocation = YES;  // Спрашиваем об использовании геолокации
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];  // Обновляем местоположение
    BOOL isFirstLunch = [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLunch"];
    if (!isFirstLunch) {   // Если это не первое посещение,то спрашиваем об использовании
        [self firstLunch];  // служб геолокации
    }
    self.view_UnderTableView.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setupMapView:(CLLocationCoordinate2D) coord {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500, 500);
    // Создаем регион и делаем расстояние от центра карты до краев равным 500 метров по высоте и широте
    [self.mapView setRegion:region animated:YES];  // Добавляем регион на карту
}
//------------------------------------------------------------------------------------------------
#pragma mark - MKMapViewDelegate
// В этом методе мы добавляем рисунок в виде метки на аннотацию
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    IBUIView * viewIB = [IBUIView new];
    if (![annotation isKindOfClass:MKUserLocation.class]) {
        MKAnnotationView * annView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Annotation"];
        annView.canShowCallout = NO;
        annView.image = [UIImage imageNamed:@"Метка.png"];
        
        [annView addSubview:[viewIB getCalloutView:annotation.title]];  // Добавляем надпись к аннотации
        return annView;
    }
    return nil;
}
// Этот метод срабатывает,когда мы нажимаем на аннотацию
-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if (![view.annotation isKindOfClass:MKUserLocation.class]) {
        for (UIView * subView in view.subviews) {
            if (subView.tag == 1000) {
                [IBAnimation change_TextField:subView Alpha:0.55];    // Делаем надпись видимой
            }
        }
    }
}
// Этот метод срабатывает,когда мы нажимаем на другую аннотацию
-(void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    for (UIView * subView in view.subviews) {
        if (subView.tag == 1000) {
            [IBAnimation change_TextField:subView Alpha:0];     // Делаем надпись невидимой
        }
    }
}
//-----------------------------------------------------------------------------------------------
#pragma mark - CLLocationManagerDelegate

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (!isCurrentLocation) {  // Если координаты изменились
        isCurrentLocation = YES;
        [self setupMapView:newLocation.coordinate];
        // то считываем новые координаты
    }
}
//------------------------------------------------------------------------------------------------
#pragma mark - UIGestureRecognizerDelegate
// Метод,обрабатывающий нажатие на карту
- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    if (sender.numberOfTapsRequired == 1 && sender.numberOfTouches == 1) {
        [IBAnimation change_View:self.view_UnderTableView Alpha:0];// При нажатии TableView исчезает
    }
}

- (IBAction)longPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) { // Если нажали на карту
        CLLocationCoordinate2D coordScreenPoint = [self.mapView convertPoint:[sender locationInView:self.mapView] toCoordinateFromView:self.mapView]; // Конвертируем точку нажатия на экране в координаты
        CLGeocoder * geocoder = [CLGeocoder new];
        CLLocation * tapLocation = [[CLLocation alloc]initWithLatitude:coordScreenPoint.latitude longitude:coordScreenPoint.longitude];  // Превращаем структуру coordScreenPoint в объект
        // Конвертируем tapLocation в geocoder
        [geocoder reverseGeocodeLocation:tapLocation completionHandler:^(NSArray *placemarks, NSError *error) // Оборачиваем taplocation в массив
        {
            CLPlacemark * place = [placemarks objectAtIndex:0];
            NSString * addressString = [NSString stringWithFormat:@"Город - %@\nУлица - %@\nИндекс - %@",[place.addressDictionary valueForKey:@"City"],[place.addressDictionary valueForKey:@"Street"],[place.addressDictionary valueForKey:@"ZIP"]];
            
            NSArray * array = [IBMakeArrays makeArray:[place.addressDictionary valueForKey:@"City"] Street:[place.addressDictionary valueForKey:@"Street"] Index:[place.addressDictionary valueForKey:@"ZIP"]];// Загружаем в массив адрес

            [arrayM addObjectsFromArray:array];// Каждый раз при нажатии longPress добавляем в массив адресс
            MKPointAnnotation * annotation = [MKPointAnnotation new];
            annotation.title = addressString;
            annotation.coordinate = coordScreenPoint;
            [self.mapView addAnnotation:annotation];  // Добавляем аннотацию на карту,при долгом нажатии на карту появится метка
        }];
    }
}
// Кнопка,которая показывает tableView и записывает историю
- (IBAction)button_ShowTableView:(id)sender {
    self.isHistoryButton = YES;
    [self reloadTableView];  // Загружаем историю с анимацией
    [IBAnimation change_View:self.view_UnderTableView Alpha:1];  // Показываем tableView
}
//--------------------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
// Этот метод сообщает контроллеру вида,сколько ячеек или строк следует загрузить в каждый раздел
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayM.count;  // Количество ячеек будет = количеству элементов массива
}
// Этот метод отвечает за возвращение экземпляров класса UITableViewCell как строк таблицы,которыми должен заполняться табличный вид
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * simpleTableIdintifiter = @"Cell";
    IBCells * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdintifiter];
    // Загружаем элементы массива по ключам
    cell.label_City.text = [[arrayM objectAtIndex:indexPath.row]objectForKey:@"Город"];
    cell.label_Street.text = [[arrayM objectAtIndex:indexPath.row]objectForKey:@"Улица"];
    cell.label_Index.text = [[arrayM objectAtIndex:indexPath.row]objectForKey:@"Индекс"];

    return cell;
}
// Этот метод загружает элементы на Table View с анимацией
-(void) reloadTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isHistoryButton)
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    });
}

@end
