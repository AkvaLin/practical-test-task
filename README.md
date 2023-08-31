# practical-test-task

<p align="center">
   <img src="https://img.shields.io/badge/iOS-14.0-blue">
   <img src="https://img.shields.io/badge/Version-v1.0-green">
</p>

## About

Приложение, состоящее из двух экранов и отображающее список товаров и детальную информацию по каждому товару

## Screenshots

|  Main View | Details View | Details View on a small screen |
| :-------------: |:-------------:|:-------------:| 
| <img src="https://i.ibb.co/N7GW096/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-33-01.png" width="250"> | <img src="https://i.ibb.co/Ss9qcs3/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-39-20.png" width="250"> | <img src="https://i.ibb.co/XLf3ypq/Simulator-Screenshot-i-Phone-SE-3rd-generation-2023-08-31-at-11-39-57.png" width="250"> |
| Loading state | Error state | Images still loading |
| <img src="https://i.ibb.co/tsLBDBD/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-35-47.png" width="250"> | <img src="https://i.ibb.co/k6k2zmt/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-36-51.png" width="250"> | <img src="https://i.ibb.co/tKTqtVw/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-33-38.png" width="250"> |
### Dark Theme
| Main View | Details View |
| :-------------: |:-------------:|
| <img src="https://i.ibb.co/GW1bcnB/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-39-35.png" width="250"> | <img src="https://i.ibb.co/tb7JSCn/Simulator-Screenshot-i-Phone-14-Pro-2023-08-31-at-11-39-40.png" width="250"> |

## Requirements

### Implementation requirement:
У каждого экрана должно быть три состояния: 
- Отображение ошибки
- Состояние загрузки
- Отображение контента из JSON файла

Внешний вид приложения реализовывается на усмотрение кандидата, за референс можно брать приложение Авито.
Для каждого экрана нужно будет загружать данные в формате JSON из интернета: 
- https://www.avito.st/s/interns-ios/main-page.json
    - URL для запроса на главном экране.
- https://www.avito.st/s/interns-ios/details/{itemId}.json
    - URL для запроса на детальной странице. ID берется из данных для главного экрана. 
    - Пример ссылки: https://www.avito.st/s/interns-ios/details/1.json

### Code Requirements:
1. Приложение написано на языке Swift. 
2. Пользовательский интерфейс приложения реализован кодом без использования SwiftUI.
3. Для отображения списка используется UICollectionView с отображением в 2 столбца.
4. Для запроса данных используется URLSession.


## Technical Description

- Swift
- UIKit
- MVVM
- Combine

## Installation and launch

1. Склонируйте репозиторий.
2. Откройте проект в Xcode.
3. Выберите целевое устройство для запуска.
4. Нажмите кнопку "Run" в Xcode для сборки и запуска приложения.
